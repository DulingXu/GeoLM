// Copyright 2021 The etcd Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//go:build !cluster_proxy
// +build !cluster_proxy

package e2e

import (
	"fmt"
	"net/url"
	"strings"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"

	"go.etcd.io/etcd/pkg/testutil"
)

func TestAuthority(t *testing.T) {
	tcs := []struct {
		name           string
		useTLS         bool
		useInsecureTLS bool
		// Pattern used to generate endpoints for client. Fields filled
		// %d - will be filled with member grpc port
		clientURLPattern string

		// Pattern used to validate authority received by server. Fields filled:
		// ${MEMBER_PORT} - will be filled with member grpc port
		expectAuthorityPattern string
	}{
		{
			name:                   "http://domain[:port]",
			clientURLPattern:       "http://localhost:%d",
			expectAuthorityPattern: "localhost:${MEMBER_PORT}",
		},
		{
			name:                   "http://address[:port]",
			clientURLPattern:       "http://127.0.0.1:%d",
			expectAuthorityPattern: "127.0.0.1:${MEMBER_PORT}",
		},
		{
			name:                   "https://domain[:port] insecure",
			useTLS:                 true,
			useInsecureTLS:         true,
			clientURLPattern:       "https://localhost:%d",
			expectAuthorityPattern: "localhost:${MEMBER_PORT}",
		},
		{
			name:                   "https://address[:port] insecure",
			useTLS:                 true,
			useInsecureTLS:         true,
			clientURLPattern:       "https://127.0.0.1:%d",
			expectAuthorityPattern: "127.0.0.1:${MEMBER_PORT}",
		},
		{
			name:                   "https://domain[:port]",
			useTLS:                 true,
			clientURLPattern:       "https://localhost:%d",
			expectAuthorityPattern: "localhost:${MEMBER_PORT}",
		},
		{
			name:                   "https://address[:port]",
			useTLS:                 true,
			clientURLPattern:       "https://127.0.0.1:%d",
			expectAuthorityPattern: "127.0.0.1:${MEMBER_PORT}",
		},
	}
	for _, tc := range tcs {
		for _, clusterSize := range []int{1, 3} {
			t.Run(fmt.Sprintf("Size: %d, Scenario: %q", clusterSize, tc.name), func(t *testing.T) {
				defer testutil.AfterTest(t)

				cfg := configNoTLS
				cfg.clusterSize = clusterSize
				if tc.useTLS {
					cfg.clientTLS = clientTLS
				}
				cfg.isClientAutoTLS = tc.useInsecureTLS
				// Enable debug mode to get logs with http2 headers (including authority)
				cfg.envVars = map[string]string{"GODEBUG": "http2debug=2"}

				epc, err := newEtcdProcessCluster(&cfg)
				if err != nil {
					t.Fatalf("could not start etcd process cluster (%v)", err)
				}
				defer epc.Close()
				endpoints := templateEndpoints(t, tc.clientURLPattern, epc)

				client := clusterEtcdctlV3(&cfg, endpoints)
				for i := 0; i < 100; i++ {
					err = client.Put("foo", "bar")
					if err != nil {
						t.Fatal(err)
					}
				}

				executeWithTimeout(t, 5*time.Second, func() {
					assertAuthority(t, tc.expectAuthorityPattern, epc)
				})
			})
		}
	}
}

func templateEndpoints(t *testing.T, pattern string, clus *etcdProcessCluster) []string {
	t.Helper()
	endpoints := []string{}
	for i := 0; i < clus.cfg.clusterSize; i++ {
		ent := pattern
		if strings.Contains(ent, "%d") {
			ent = fmt.Sprintf(ent, etcdProcessBasePort+i*5)
		}
		if strings.Contains(ent, "%") {
			t.Fatalf("Failed to template pattern, %% symbol left %q", ent)
		}
		endpoints = append(endpoints, ent)
	}
	return endpoints
}

func assertAuthority(t *testing.T, expectAuthorityPattern string, clus *etcdProcessCluster) {
	for i := range clus.procs {
		line, _ := clus.procs[i].Logs().Expect(`http2: decoded hpack field header field ":authority"`)
		line = strings.TrimSuffix(line, "\n")
		line = strings.TrimSuffix(line, "\r")
		u, err := url.Parse(clus.procs[i].EndpointsGRPC()[0])
		if err != nil {
			t.Fatal(err)
		}
		expectAuthority := strings.ReplaceAll(expectAuthorityPattern, "${MEMBER_PORT}", u.Port())
		expectLine := fmt.Sprintf(`http2: decoded hpack field header field ":authority" = %q`, expectAuthority)
		assert.True(t, strings.HasSuffix(line, expectLine), fmt.Sprintf("Got %q expected suffix %q", line, expectLine))
	}
}

func executeWithTimeout(t *testing.T, timeout time.Duration, f func()) {
	donec := make(chan struct{})
	go func() {
		defer close(donec)
		f()
	}()

	select {
	case <-time.After(timeout):
		testutil.FatalStack(t, fmt.Sprintf("test timed out after %v", timeout))
	case <-donec:
	}
}

type etcdctlV3 struct {
	cfg       *etcdProcessClusterConfig
	endpoints []string
}

func clusterEtcdctlV3(cfg *etcdProcessClusterConfig, endpoints []string) *etcdctlV3 {
	return &etcdctlV3{
		cfg:       cfg,
		endpoints: endpoints,
	}
}

func (ctl *etcdctlV3) Put(key, value string) error {
	return ctl.runCmd("put", key, value)
}

func (ctl *etcdctlV3) runCmd(args ...string) error {
	cmdArgs := []string{ctlBinPath + "3"}
	for k, v := range ctl.flags() {
		cmdArgs = append(cmdArgs, fmt.Sprintf("--%s=%s", k, v))
	}
	cmdArgs = append(cmdArgs, args...)
	return spawnWithExpect(cmdArgs, "OK")
}

func (ctl *etcdctlV3) flags() map[string]string {
	fmap := make(map[string]string)
	if ctl.cfg.clientTLS == clientTLS {
		if ctl.cfg.isClientAutoTLS {
			fmap["insecure-transport"] = "false"
			fmap["insecure-skip-tls-verify"] = "true"
		} else if ctl.cfg.isClientCRL {
			fmap["cacert"] = caPath
			fmap["cert"] = revokedCertPath
			fmap["key"] = revokedPrivateKeyPath
		} else {
			fmap["cacert"] = caPath
			fmap["cert"] = certPath
			fmap["key"] = privateKeyPath
		}
	}
	fmap["endpoints"] = strings.Join(ctl.endpoints, ",")
	return fmap
}
