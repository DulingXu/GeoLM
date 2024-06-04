// Copyright 2016 The etcd Authors
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

package clientv3

import (
	"context"
	"fmt"
	"io"
	"net"
	"sync"
	"testing"
	"time"

	"go.etcd.io/etcd/etcdserver/api/v3rpc/rpctypes"
	"go.etcd.io/etcd/etcdserver/etcdserverpb"
	"go.etcd.io/etcd/pkg/testutil"

	"google.golang.org/grpc"
)

func TestDialCancel(t *testing.T) {
	defer testutil.AfterTest(t)

	// accept first connection so client is created with dial timeout
	ln, err := net.Listen("unix", "dialcancel:12345")
	if err != nil {
		t.Fatal(err)
	}
	defer ln.Close()

	ep := "unix://dialcancel:12345"
	cfg := Config{
		Endpoints:   []string{ep},
		DialTimeout: 30 * time.Second}
	c, err := New(cfg)
	if err != nil {
		t.Fatal(err)
	}

	// connect to ipv4 black hole so dial blocks
	c.SetEndpoints("http://254.0.0.1:12345")

	// issue Get to force redial attempts
	getc := make(chan struct{})
	go func() {
		defer close(getc)
		// Get may hang forever on grpc's Stream.Header() if its
		// context is never canceled.
		c.Get(c.Ctx(), "abc")
	}()

	// wait a little bit so client close is after dial starts
	time.Sleep(100 * time.Millisecond)

	donec := make(chan struct{})
	go func() {
		defer close(donec)
		c.Close()
	}()

	select {
	case <-time.After(5 * time.Second):
		t.Fatalf("failed to close")
	case <-donec:
	}
	select {
	case <-time.After(5 * time.Second):
		t.Fatalf("get failed to exit")
	case <-getc:
	}
}

func TestDialTimeout(t *testing.T) {
	defer testutil.AfterTest(t)

	wantError := context.DeadlineExceeded

	// grpc.WithBlock to block until connection up or timeout
	testCfgs := []Config{
		{
			Endpoints:   []string{"http://254.0.0.1:12345"},
			DialTimeout: 2 * time.Second,
			DialOptions: []grpc.DialOption{grpc.WithBlock()},
		},
		{
			Endpoints:   []string{"http://254.0.0.1:12345"},
			DialTimeout: time.Second,
			DialOptions: []grpc.DialOption{grpc.WithBlock()},
			Username:    "abc",
			Password:    "def",
		},
	}

	for i, cfg := range testCfgs {
		donec := make(chan error)
		go func() {
			// without timeout, dial continues forever on ipv4 black hole
			c, err := New(cfg)
			if c != nil || err == nil {
				t.Errorf("#%d: new client should fail", i)
			}
			donec <- err
		}()

		time.Sleep(10 * time.Millisecond)

		select {
		case err := <-donec:
			t.Errorf("#%d: dial didn't wait (%v)", i, err)
		default:
		}

		select {
		case <-time.After(5 * time.Second):
			t.Errorf("#%d: failed to timeout dial on time", i)
		case err := <-donec:
			if err.Error() != wantError.Error() {
				t.Errorf("#%d: unexpected error '%v', want '%v'", i, err, wantError)
			}
		}
	}
}

func TestDialNoTimeout(t *testing.T) {
	cfg := Config{Endpoints: []string{"127.0.0.1:12345"}}
	c, err := New(cfg)
	if c == nil || err != nil {
		t.Fatalf("new client with DialNoWait should succeed, got %v", err)
	}
	c.Close()
}

func TestIsHaltErr(t *testing.T) {
	if !isHaltErr(nil, fmt.Errorf("etcdserver: some etcdserver error")) {
		t.Errorf(`error prefixed with "etcdserver: " should be Halted by default`)
	}
	if isHaltErr(nil, rpctypes.ErrGRPCStopped) {
		t.Errorf("error %v should not halt", rpctypes.ErrGRPCStopped)
	}
	if isHaltErr(nil, rpctypes.ErrGRPCNoLeader) {
		t.Errorf("error %v should not halt", rpctypes.ErrGRPCNoLeader)
	}
	ctx, cancel := context.WithCancel(context.TODO())
	if isHaltErr(ctx, nil) {
		t.Errorf("no error and active context should not be Halted")
	}
	cancel()
	if !isHaltErr(ctx, nil) {
		t.Errorf("cancel on context should be Halted")
	}
}

func TestCloseCtxClient(t *testing.T) {
	ctx := context.Background()
	c := NewCtxClient(ctx)
	err := c.Close()
	// Close returns ctx.toErr, a nil error means an open Done channel
	if err == nil {
		t.Errorf("failed to Close the client. %v", err)
	}
}

func TestSyncFiltersMembers(t *testing.T) {
	defer testutil.AfterTest(t)

	c, _ := New(Config{Endpoints: []string{"http://254.0.0.1:12345"}})
	c.Cluster = &mockCluster{
		[]*etcdserverpb.Member{
			{ID: 0, Name: "", ClientURLs: []string{"http://254.0.0.1:12345"}, IsLearner: false},
			{ID: 1, Name: "isStarted", ClientURLs: []string{"http://254.0.0.2:12345"}, IsLearner: true},
			{ID: 2, Name: "isStartedAndNotLearner", ClientURLs: []string{"http://254.0.0.3:12345"}, IsLearner: false},
		},
	}
	c.Sync(context.Background())

	endpoints := c.Endpoints()
	if len(endpoints) != 1 || endpoints[0] != "http://254.0.0.3:12345" {
		t.Error("Client.Sync uses learner and/or non-started member client URLs")
	}
	c.Close()
}

func TestClientRejectOldCluster(t *testing.T) {
	defer testutil.AfterTest(t)
	var tests = []struct {
		name          string
		endpoints     []string
		versions      []string
		expectedError error
	}{
		{
			name:          "all new versions with the same value",
			endpoints:     []string{"192.168.3.41:22379", "192.168.3.41:22479", "192.168.3.41:22579"},
			versions:      []string{"3.4.4", "3.4.4", "3.4.4"},
			expectedError: nil,
		},
		{
			name:          "all new versions with different values",
			endpoints:     []string{"192.168.3.41:22379", "192.168.3.41:22479", "192.168.3.41:22579"},
			versions:      []string{"3.4.4", "3.4.4", "3.4.0"},
			expectedError: nil,
		},
		{
			name:          "all old versions with different values",
			endpoints:     []string{"192.168.3.41:22379", "192.168.3.41:22479", "192.168.3.41:22579"},
			versions:      []string{"3.2.0", "3.2.0", "3.3.0"},
			expectedError: ErrOldCluster,
		},
		{
			name:          "all old versions with the same value",
			endpoints:     []string{"192.168.3.41:22379", "192.168.3.41:22479", "192.168.3.41:22579"},
			versions:      []string{"3.2.0", "3.2.0", "3.2.0"},
			expectedError: ErrOldCluster,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if len(tt.endpoints) != len(tt.versions) || len(tt.endpoints) == 0 {
				t.Errorf("Unexpected endpoints and versions length, len(endpoints):%d, len(versions):%d", len(tt.endpoints), len(tt.versions))
				return
			}
			endpointToVersion := make(map[string]string)
			for j := range tt.endpoints {
				endpointToVersion[tt.endpoints[j]] = tt.versions[j]
			}
			c := &Client{
				ctx:       context.Background(),
				endpoints: tt.endpoints,
				epMu:      new(sync.RWMutex),
				Maintenance: &mockMaintenance{
					Version: endpointToVersion,
				},
			}

			if err := c.checkVersion(); err != tt.expectedError {
				t.Errorf("checkVersion err:%v", err)
			}
		})

	}

}

type mockMaintenance struct {
	Version map[string]string
}

func (mm mockMaintenance) Status(ctx context.Context, endpoint string) (*StatusResponse, error) {
	return &StatusResponse{Version: mm.Version[endpoint]}, nil
}

func (mm mockMaintenance) AlarmList(ctx context.Context) (*AlarmResponse, error) {
	return nil, nil
}

func (mm mockMaintenance) AlarmDisarm(ctx context.Context, m *AlarmMember) (*AlarmResponse, error) {
	return nil, nil
}

func (mm mockMaintenance) Defragment(ctx context.Context, endpoint string) (*DefragmentResponse, error) {
	return nil, nil
}

func (mm mockMaintenance) HashKV(ctx context.Context, endpoint string, rev int64) (*HashKVResponse, error) {
	return nil, nil
}

func (mm mockMaintenance) SnapshotWithVersion(ctx context.Context) error {
	return nil
}

func (mm mockMaintenance) Snapshot(ctx context.Context) (io.ReadCloser, error) {
	return nil, nil
}

func (mm mockMaintenance) MoveLeader(ctx context.Context, transfereeID uint64) (*MoveLeaderResponse, error) {
	return nil, nil
}

func (mm mockMaintenance) Downgrade(ctx context.Context, version string) error {
	return nil
}

type mockCluster struct {
	members []*etcdserverpb.Member
}

func (mc *mockCluster) MemberList(ctx context.Context) (*MemberListResponse, error) {
	return &MemberListResponse{Members: mc.members}, nil
}

func (mc *mockCluster) MemberAdd(ctx context.Context, peerAddrs []string) (*MemberAddResponse, error) {
	return nil, nil
}

func (mc *mockCluster) MemberAddAsLearner(ctx context.Context, peerAddrs []string) (*MemberAddResponse, error) {
	return nil, nil
}

func (mc *mockCluster) MemberRemove(ctx context.Context, id uint64) (*MemberRemoveResponse, error) {
	return nil, nil
}

func (mc *mockCluster) MemberUpdate(ctx context.Context, id uint64, peerAddrs []string) (*MemberUpdateResponse, error) {
	return nil, nil
}

func (mc *mockCluster) MemberPromote(ctx context.Context, id uint64) (*MemberPromoteResponse, error) {
	return nil, nil
}
