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

package integration

import (
	"testing"
	"time"

	"go.etcd.io/etcd/clientv3"
	"go.etcd.io/etcd/contrib/recipes"
	"go.etcd.io/etcd/pkg/testutil"
)

func TestBarrierSingleNode(t *testing.T) {
	defer testutil.AfterTest(t)
	clus := NewClusterV3(t, &ClusterConfig{Size: 1})
	defer clus.Terminate(t)
	testBarrier(t, 5, func() *clientv3.Client { return clus.clients[0] })
}

func TestBarrierMultiNode(t *testing.T) {
	defer testutil.AfterTest(t)
	clus := NewClusterV3(t, &ClusterConfig{Size: 3})
	defer clus.Terminate(t)
	testBarrier(t, 5, func() *clientv3.Client { return clus.RandClient() })
}

func testBarrier(t *testing.T, waiters int, chooseClient func() *clientv3.Client) {
	b := recipe.NewBarrier(chooseClient(), "test-barrier")
	if err := b.Hold(); err != nil {
		t.Fatalf("could not hold barrier (%v)", err)
	}
	if err := b.Hold(); err == nil {
		t.Fatalf("able to double-hold barrier")
	}

	donec := make(chan struct{})
	for i := 0; i < waiters; i++ {
		go func() {
			br := recipe.NewBarrier(chooseClient(), "test-barrier")
			if err := br.Wait(); err != nil {
				t.Errorf("could not wait on barrier (%v)", err)
			}
			donec <- struct{}{}
		}()
	}

	select {
	case <-donec:
		t.Fatalf("barrier did not wait")
	default:
	}

	if err := b.Release(); err != nil {
		t.Fatalf("could not release barrier (%v)", err)
	}

	timerC := time.After(time.Duration(waiters*100) * time.Millisecond)
	for i := 0; i < waiters; i++ {
		select {
		case <-timerC:
			t.Fatalf("barrier timed out")
		case <-donec:
		}
	}
}

func TestBarrierWaitNonexistentKey(t *testing.T) {
	defer testutil.AfterTest(t)
	clus := NewClusterV3(t, &ClusterConfig{Size: 1})
	defer clus.Terminate(t)
	cli := clus.clients[0]

	if _, err := cli.Put(cli.Ctx(), "test-barrier-0", ""); err != nil {
		t.Errorf("could not put test-barrier0, err:%v", err)
	}

	donec := make(chan struct{})
	stopc := make(chan struct{})
	defer close(stopc)

	waiters := 5
	for i := 0; i < waiters; i++ {
		go func() {
			br := recipe.NewBarrier(cli, "test-barrier")
			if err := br.Wait(); err != nil {
				t.Errorf("could not wait on barrier (%v)", err)
			}
			select {
			case donec <- struct{}{}:
			case <-stopc:
			}
		}()
	}

	// all waiters should return immediately if waiting on a nonexistent key "test-barrier" even if key "test-barrier-0" exists
	timerC := time.After(time.Duration(waiters*100) * time.Millisecond)
	for i := 0; i < waiters; i++ {
		select {
		case <-timerC:
			t.Fatal("barrier timed out")
		case <-donec:
		}
	}
}
