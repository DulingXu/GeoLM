docker exec -d glee2 /expr/glee-etcd --data-dir=/expr/data --name infra2 --listen-client-urls http://192.168.37.12:2379 --advertise-client-urls http://192.168.37.12:2379 --listen-peer-urls http://192.168.37.12:2380 --initial-advertise-peer-urls http://192.168.37.12:2380 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1=http://192.168.37.11:2380,infra2=http://192.168.37.12:2380,infra3=http://192.168.37.13:2380' --initial-cluster-state new --enable-pprof

sleep 2

docker exec -d glee1 /expr/glee-etcd --data-dir=/expr/data --name infra1 --listen-client-urls http://192.168.37.11:2379 --advertise-client-urls http://192.168.37.11:2379 --listen-peer-urls http://192.168.37.11:2380 --initial-advertise-peer-urls http://192.168.37.11:2380 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1=http://192.168.37.11:2380,infra2=http://192.168.37.12:2380,infra3=http://192.168.37.13:2380' --initial-cluster-state new --enable-pprof

docker exec -d glee3 /expr/glee-etcd --data-dir=/expr/data --name infra3 --listen-client-urls http://192.168.37.13:2379 --advertise-client-urls http://192.168.37.13:2379 --listen-peer-urls http://192.168.37.13:2380 --initial-advertise-peer-urls http://192.168.37.13:2380 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1=http://192.168.37.11:2380,infra2=http://192.168.37.12:2380,infra3=http://192.168.37.13:2380' --initial-cluster-state new --enable-pprof

