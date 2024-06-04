docker exec -d glee8 /expr/etcd --data-dir=/expr/data1 --name infra8-1 --listen-client-urls http://192.168.37.18:2379 --advertise-client-urls http://192.168.37.18:2379 --listen-peer-urls http://192.168.37.18:2380 --initial-advertise-peer-urls http://192.168.37.18:2380 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1-1=http://192.168.37.11:2380,infra1-2=http://192.168.37.11:2382,infra1-3=http://192.168.37.11:2384,infra1-4=http://192.168.37.11:2386,infra1-5=http://192.168.37.11:2388,infra1-6=http://192.168.37.11:2390,infra1-7=http://192.168.37.11:2392,infra2-1=http://192.168.37.12:2380,infra2-2=http://192.168.37.12:2382,infra2-3=http://192.168.37.12:2384,infra2-4=http://192.168.37.12:2386,infra2-5=http://192.168.37.12:2388,infra2-6=http://192.168.37.12:2390,infra2-7=http://192.168.37.12:2392,infra3-1=http://192.168.37.13:2380,infra3-2=http://192.168.37.13:2382,infra3-3=http://192.168.37.13:2384,infra3-4=http://192.168.37.13:2386,infra3-5=http://192.168.37.13:2388,infra3-6=http://192.168.37.13:2390,infra3-7=http://192.168.37.13:2392,infra4-1=http://192.168.37.14:2380,infra4-2=http://192.168.37.14:2382,infra4-3=http://192.168.37.14:2384,infra4-4=http://192.168.37.14:2386,infra4-5=http://192.168.37.14:2388,infra4-6=http://192.168.37.14:2390,infra4-7=http://192.168.37.14:2392,infra5-1=http://192.168.37.15:2380,infra5-2=http://192.168.37.15:2382,infra5-3=http://192.168.37.15:2384,infra5-4=http://192.168.37.15:2386,infra5-5=http://192.168.37.15:2388,infra5-6=http://192.168.37.15:2390,infra5-7=http://192.168.37.15:2392,infra6-1=http://192.168.37.16:2380,infra6-2=http://192.168.37.16:2382,infra6-3=http://192.168.37.16:2384,infra6-4=http://192.168.37.16:2386,infra6-5=http://192.168.37.16:2388,infra6-6=http://192.168.37.16:2390,infra6-7=http://192.168.37.16:2392,infra7-1=http://192.168.37.17:2380,infra7-2=http://192.168.37.17:2382,infra7-3=http://192.168.37.17:2384,infra7-4=http://192.168.37.17:2386,infra7-5=http://192.168.37.17:2388,infra7-6=http://192.168.37.17:2390,infra7-7=http://192.168.37.17:2392,infra8-1=http://192.168.37.18:2380,infra8-2=http://192.168.37.18:2382,infra8-3=http://192.168.37.18:2384,infra8-4=http://192.168.37.18:2386,infra8-5=http://192.168.37.18:2388,infra8-6=http://192.168.37.18:2390,infra8-7=http://192.168.37.18:2392,infra9-1=http://192.168.37.19:2380,infra9-2=http://192.168.37.19:2382,infra9-3=http://192.168.37.19:2384,infra9-4=http://192.168.37.19:2386,infra9-5=http://192.168.37.19:2388,infra9-6=http://192.168.37.19:2390,infra9-7=http://192.168.37.19:2392' --initial-cluster-state new --enable-pprof

docker exec -d glee8 /expr/etcd --data-dir=/expr/data2 --name infra8-2 --listen-client-urls http://192.168.37.18:2381 --advertise-client-urls http://192.168.37.18:2381 --listen-peer-urls http://192.168.37.18:2382 --initial-advertise-peer-urls http://192.168.37.18:2382 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1-1=http://192.168.37.11:2380,infra1-2=http://192.168.37.11:2382,infra1-3=http://192.168.37.11:2384,infra1-4=http://192.168.37.11:2386,infra1-5=http://192.168.37.11:2388,infra1-6=http://192.168.37.11:2390,infra1-7=http://192.168.37.11:2392,infra2-1=http://192.168.37.12:2380,infra2-2=http://192.168.37.12:2382,infra2-3=http://192.168.37.12:2384,infra2-4=http://192.168.37.12:2386,infra2-5=http://192.168.37.12:2388,infra2-6=http://192.168.37.12:2390,infra2-7=http://192.168.37.12:2392,infra3-1=http://192.168.37.13:2380,infra3-2=http://192.168.37.13:2382,infra3-3=http://192.168.37.13:2384,infra3-4=http://192.168.37.13:2386,infra3-5=http://192.168.37.13:2388,infra3-6=http://192.168.37.13:2390,infra3-7=http://192.168.37.13:2392,infra4-1=http://192.168.37.14:2380,infra4-2=http://192.168.37.14:2382,infra4-3=http://192.168.37.14:2384,infra4-4=http://192.168.37.14:2386,infra4-5=http://192.168.37.14:2388,infra4-6=http://192.168.37.14:2390,infra4-7=http://192.168.37.14:2392,infra5-1=http://192.168.37.15:2380,infra5-2=http://192.168.37.15:2382,infra5-3=http://192.168.37.15:2384,infra5-4=http://192.168.37.15:2386,infra5-5=http://192.168.37.15:2388,infra5-6=http://192.168.37.15:2390,infra5-7=http://192.168.37.15:2392,infra6-1=http://192.168.37.16:2380,infra6-2=http://192.168.37.16:2382,infra6-3=http://192.168.37.16:2384,infra6-4=http://192.168.37.16:2386,infra6-5=http://192.168.37.16:2388,infra6-6=http://192.168.37.16:2390,infra6-7=http://192.168.37.16:2392,infra7-1=http://192.168.37.17:2380,infra7-2=http://192.168.37.17:2382,infra7-3=http://192.168.37.17:2384,infra7-4=http://192.168.37.17:2386,infra7-5=http://192.168.37.17:2388,infra7-6=http://192.168.37.17:2390,infra7-7=http://192.168.37.17:2392,infra8-1=http://192.168.37.18:2380,infra8-2=http://192.168.37.18:2382,infra8-3=http://192.168.37.18:2384,infra8-4=http://192.168.37.18:2386,infra8-5=http://192.168.37.18:2388,infra8-6=http://192.168.37.18:2390,infra8-7=http://192.168.37.18:2392,infra9-1=http://192.168.37.19:2380,infra9-2=http://192.168.37.19:2382,infra9-3=http://192.168.37.19:2384,infra9-4=http://192.168.37.19:2386,infra9-5=http://192.168.37.19:2388,infra9-6=http://192.168.37.19:2390,infra9-7=http://192.168.37.19:2392' --initial-cluster-state new --enable-pprof

docker exec -d glee8 /expr/etcd --data-dir=/expr/data3 --name infra8-3 --listen-client-urls http://192.168.37.18:2383 --advertise-client-urls http://192.168.37.18:2383 --listen-peer-urls http://192.168.37.18:2384 --initial-advertise-peer-urls http://192.168.37.18:2384 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1-1=http://192.168.37.11:2380,infra1-2=http://192.168.37.11:2382,infra1-3=http://192.168.37.11:2384,infra1-4=http://192.168.37.11:2386,infra1-5=http://192.168.37.11:2388,infra1-6=http://192.168.37.11:2390,infra1-7=http://192.168.37.11:2392,infra2-1=http://192.168.37.12:2380,infra2-2=http://192.168.37.12:2382,infra2-3=http://192.168.37.12:2384,infra2-4=http://192.168.37.12:2386,infra2-5=http://192.168.37.12:2388,infra2-6=http://192.168.37.12:2390,infra2-7=http://192.168.37.12:2392,infra3-1=http://192.168.37.13:2380,infra3-2=http://192.168.37.13:2382,infra3-3=http://192.168.37.13:2384,infra3-4=http://192.168.37.13:2386,infra3-5=http://192.168.37.13:2388,infra3-6=http://192.168.37.13:2390,infra3-7=http://192.168.37.13:2392,infra4-1=http://192.168.37.14:2380,infra4-2=http://192.168.37.14:2382,infra4-3=http://192.168.37.14:2384,infra4-4=http://192.168.37.14:2386,infra4-5=http://192.168.37.14:2388,infra4-6=http://192.168.37.14:2390,infra4-7=http://192.168.37.14:2392,infra5-1=http://192.168.37.15:2380,infra5-2=http://192.168.37.15:2382,infra5-3=http://192.168.37.15:2384,infra5-4=http://192.168.37.15:2386,infra5-5=http://192.168.37.15:2388,infra5-6=http://192.168.37.15:2390,infra5-7=http://192.168.37.15:2392,infra6-1=http://192.168.37.16:2380,infra6-2=http://192.168.37.16:2382,infra6-3=http://192.168.37.16:2384,infra6-4=http://192.168.37.16:2386,infra6-5=http://192.168.37.16:2388,infra6-6=http://192.168.37.16:2390,infra6-7=http://192.168.37.16:2392,infra7-1=http://192.168.37.17:2380,infra7-2=http://192.168.37.17:2382,infra7-3=http://192.168.37.17:2384,infra7-4=http://192.168.37.17:2386,infra7-5=http://192.168.37.17:2388,infra7-6=http://192.168.37.17:2390,infra7-7=http://192.168.37.17:2392,infra8-1=http://192.168.37.18:2380,infra8-2=http://192.168.37.18:2382,infra8-3=http://192.168.37.18:2384,infra8-4=http://192.168.37.18:2386,infra8-5=http://192.168.37.18:2388,infra8-6=http://192.168.37.18:2390,infra8-7=http://192.168.37.18:2392,infra9-1=http://192.168.37.19:2380,infra9-2=http://192.168.37.19:2382,infra9-3=http://192.168.37.19:2384,infra9-4=http://192.168.37.19:2386,infra9-5=http://192.168.37.19:2388,infra9-6=http://192.168.37.19:2390,infra9-7=http://192.168.37.19:2392' --initial-cluster-state new --enable-pprof

docker exec -d glee8 /expr/etcd --data-dir=/expr/data4 --name infra8-4 --listen-client-urls http://192.168.37.18:2385 --advertise-client-urls http://192.168.37.18:2385 --listen-peer-urls http://192.168.37.18:2386 --initial-advertise-peer-urls http://192.168.37.18:2386 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1-1=http://192.168.37.11:2380,infra1-2=http://192.168.37.11:2382,infra1-3=http://192.168.37.11:2384,infra1-4=http://192.168.37.11:2386,infra1-5=http://192.168.37.11:2388,infra1-6=http://192.168.37.11:2390,infra1-7=http://192.168.37.11:2392,infra2-1=http://192.168.37.12:2380,infra2-2=http://192.168.37.12:2382,infra2-3=http://192.168.37.12:2384,infra2-4=http://192.168.37.12:2386,infra2-5=http://192.168.37.12:2388,infra2-6=http://192.168.37.12:2390,infra2-7=http://192.168.37.12:2392,infra3-1=http://192.168.37.13:2380,infra3-2=http://192.168.37.13:2382,infra3-3=http://192.168.37.13:2384,infra3-4=http://192.168.37.13:2386,infra3-5=http://192.168.37.13:2388,infra3-6=http://192.168.37.13:2390,infra3-7=http://192.168.37.13:2392,infra4-1=http://192.168.37.14:2380,infra4-2=http://192.168.37.14:2382,infra4-3=http://192.168.37.14:2384,infra4-4=http://192.168.37.14:2386,infra4-5=http://192.168.37.14:2388,infra4-6=http://192.168.37.14:2390,infra4-7=http://192.168.37.14:2392,infra5-1=http://192.168.37.15:2380,infra5-2=http://192.168.37.15:2382,infra5-3=http://192.168.37.15:2384,infra5-4=http://192.168.37.15:2386,infra5-5=http://192.168.37.15:2388,infra5-6=http://192.168.37.15:2390,infra5-7=http://192.168.37.15:2392,infra6-1=http://192.168.37.16:2380,infra6-2=http://192.168.37.16:2382,infra6-3=http://192.168.37.16:2384,infra6-4=http://192.168.37.16:2386,infra6-5=http://192.168.37.16:2388,infra6-6=http://192.168.37.16:2390,infra6-7=http://192.168.37.16:2392,infra7-1=http://192.168.37.17:2380,infra7-2=http://192.168.37.17:2382,infra7-3=http://192.168.37.17:2384,infra7-4=http://192.168.37.17:2386,infra7-5=http://192.168.37.17:2388,infra7-6=http://192.168.37.17:2390,infra7-7=http://192.168.37.17:2392,infra8-1=http://192.168.37.18:2380,infra8-2=http://192.168.37.18:2382,infra8-3=http://192.168.37.18:2384,infra8-4=http://192.168.37.18:2386,infra8-5=http://192.168.37.18:2388,infra8-6=http://192.168.37.18:2390,infra8-7=http://192.168.37.18:2392,infra9-1=http://192.168.37.19:2380,infra9-2=http://192.168.37.19:2382,infra9-3=http://192.168.37.19:2384,infra9-4=http://192.168.37.19:2386,infra9-5=http://192.168.37.19:2388,infra9-6=http://192.168.37.19:2390,infra9-7=http://192.168.37.19:2392' --initial-cluster-state new --enable-pprof

docker exec -d glee8 /expr/etcd --data-dir=/expr/data5 --name infra8-5 --listen-client-urls http://192.168.37.18:2387 --advertise-client-urls http://192.168.37.18:2387 --listen-peer-urls http://192.168.37.18:2388 --initial-advertise-peer-urls http://192.168.37.18:2388 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1-1=http://192.168.37.11:2380,infra1-2=http://192.168.37.11:2382,infra1-3=http://192.168.37.11:2384,infra1-4=http://192.168.37.11:2386,infra1-5=http://192.168.37.11:2388,infra1-6=http://192.168.37.11:2390,infra1-7=http://192.168.37.11:2392,infra2-1=http://192.168.37.12:2380,infra2-2=http://192.168.37.12:2382,infra2-3=http://192.168.37.12:2384,infra2-4=http://192.168.37.12:2386,infra2-5=http://192.168.37.12:2388,infra2-6=http://192.168.37.12:2390,infra2-7=http://192.168.37.12:2392,infra3-1=http://192.168.37.13:2380,infra3-2=http://192.168.37.13:2382,infra3-3=http://192.168.37.13:2384,infra3-4=http://192.168.37.13:2386,infra3-5=http://192.168.37.13:2388,infra3-6=http://192.168.37.13:2390,infra3-7=http://192.168.37.13:2392,infra4-1=http://192.168.37.14:2380,infra4-2=http://192.168.37.14:2382,infra4-3=http://192.168.37.14:2384,infra4-4=http://192.168.37.14:2386,infra4-5=http://192.168.37.14:2388,infra4-6=http://192.168.37.14:2390,infra4-7=http://192.168.37.14:2392,infra5-1=http://192.168.37.15:2380,infra5-2=http://192.168.37.15:2382,infra5-3=http://192.168.37.15:2384,infra5-4=http://192.168.37.15:2386,infra5-5=http://192.168.37.15:2388,infra5-6=http://192.168.37.15:2390,infra5-7=http://192.168.37.15:2392,infra6-1=http://192.168.37.16:2380,infra6-2=http://192.168.37.16:2382,infra6-3=http://192.168.37.16:2384,infra6-4=http://192.168.37.16:2386,infra6-5=http://192.168.37.16:2388,infra6-6=http://192.168.37.16:2390,infra6-7=http://192.168.37.16:2392,infra7-1=http://192.168.37.17:2380,infra7-2=http://192.168.37.17:2382,infra7-3=http://192.168.37.17:2384,infra7-4=http://192.168.37.17:2386,infra7-5=http://192.168.37.17:2388,infra7-6=http://192.168.37.17:2390,infra7-7=http://192.168.37.17:2392,infra8-1=http://192.168.37.18:2380,infra8-2=http://192.168.37.18:2382,infra8-3=http://192.168.37.18:2384,infra8-4=http://192.168.37.18:2386,infra8-5=http://192.168.37.18:2388,infra8-6=http://192.168.37.18:2390,infra8-7=http://192.168.37.18:2392,infra9-1=http://192.168.37.19:2380,infra9-2=http://192.168.37.19:2382,infra9-3=http://192.168.37.19:2384,infra9-4=http://192.168.37.19:2386,infra9-5=http://192.168.37.19:2388,infra9-6=http://192.168.37.19:2390,infra9-7=http://192.168.37.19:2392' --initial-cluster-state new --enable-pprof

docker exec -d glee8 /expr/etcd --data-dir=/expr/data6 --name infra8-6 --listen-client-urls http://192.168.37.18:2389 --advertise-client-urls http://192.168.37.18:2389 --listen-peer-urls http://192.168.37.18:2390 --initial-advertise-peer-urls http://192.168.37.18:2390 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1-1=http://192.168.37.11:2380,infra1-2=http://192.168.37.11:2382,infra1-3=http://192.168.37.11:2384,infra1-4=http://192.168.37.11:2386,infra1-5=http://192.168.37.11:2388,infra1-6=http://192.168.37.11:2390,infra1-7=http://192.168.37.11:2392,infra2-1=http://192.168.37.12:2380,infra2-2=http://192.168.37.12:2382,infra2-3=http://192.168.37.12:2384,infra2-4=http://192.168.37.12:2386,infra2-5=http://192.168.37.12:2388,infra2-6=http://192.168.37.12:2390,infra2-7=http://192.168.37.12:2392,infra3-1=http://192.168.37.13:2380,infra3-2=http://192.168.37.13:2382,infra3-3=http://192.168.37.13:2384,infra3-4=http://192.168.37.13:2386,infra3-5=http://192.168.37.13:2388,infra3-6=http://192.168.37.13:2390,infra3-7=http://192.168.37.13:2392,infra4-1=http://192.168.37.14:2380,infra4-2=http://192.168.37.14:2382,infra4-3=http://192.168.37.14:2384,infra4-4=http://192.168.37.14:2386,infra4-5=http://192.168.37.14:2388,infra4-6=http://192.168.37.14:2390,infra4-7=http://192.168.37.14:2392,infra5-1=http://192.168.37.15:2380,infra5-2=http://192.168.37.15:2382,infra5-3=http://192.168.37.15:2384,infra5-4=http://192.168.37.15:2386,infra5-5=http://192.168.37.15:2388,infra5-6=http://192.168.37.15:2390,infra5-7=http://192.168.37.15:2392,infra6-1=http://192.168.37.16:2380,infra6-2=http://192.168.37.16:2382,infra6-3=http://192.168.37.16:2384,infra6-4=http://192.168.37.16:2386,infra6-5=http://192.168.37.16:2388,infra6-6=http://192.168.37.16:2390,infra6-7=http://192.168.37.16:2392,infra7-1=http://192.168.37.17:2380,infra7-2=http://192.168.37.17:2382,infra7-3=http://192.168.37.17:2384,infra7-4=http://192.168.37.17:2386,infra7-5=http://192.168.37.17:2388,infra7-6=http://192.168.37.17:2390,infra7-7=http://192.168.37.17:2392,infra8-1=http://192.168.37.18:2380,infra8-2=http://192.168.37.18:2382,infra8-3=http://192.168.37.18:2384,infra8-4=http://192.168.37.18:2386,infra8-5=http://192.168.37.18:2388,infra8-6=http://192.168.37.18:2390,infra8-7=http://192.168.37.18:2392,infra9-1=http://192.168.37.19:2380,infra9-2=http://192.168.37.19:2382,infra9-3=http://192.168.37.19:2384,infra9-4=http://192.168.37.19:2386,infra9-5=http://192.168.37.19:2388,infra9-6=http://192.168.37.19:2390,infra9-7=http://192.168.37.19:2392' --initial-cluster-state new --enable-pprof

docker exec -d glee8 /expr/etcd --data-dir=/expr/data7 --name infra8-7 --listen-client-urls http://192.168.37.18:2391 --advertise-client-urls http://192.168.37.18:2391 --listen-peer-urls http://192.168.37.18:2392 --initial-advertise-peer-urls http://192.168.37.18:2392 --initial-cluster-token etcd-cluster-1 --initial-cluster 'infra1-1=http://192.168.37.11:2380,infra1-2=http://192.168.37.11:2382,infra1-3=http://192.168.37.11:2384,infra1-4=http://192.168.37.11:2386,infra1-5=http://192.168.37.11:2388,infra1-6=http://192.168.37.11:2390,infra1-7=http://192.168.37.11:2392,infra2-1=http://192.168.37.12:2380,infra2-2=http://192.168.37.12:2382,infra2-3=http://192.168.37.12:2384,infra2-4=http://192.168.37.12:2386,infra2-5=http://192.168.37.12:2388,infra2-6=http://192.168.37.12:2390,infra2-7=http://192.168.37.12:2392,infra3-1=http://192.168.37.13:2380,infra3-2=http://192.168.37.13:2382,infra3-3=http://192.168.37.13:2384,infra3-4=http://192.168.37.13:2386,infra3-5=http://192.168.37.13:2388,infra3-6=http://192.168.37.13:2390,infra3-7=http://192.168.37.13:2392,infra4-1=http://192.168.37.14:2380,infra4-2=http://192.168.37.14:2382,infra4-3=http://192.168.37.14:2384,infra4-4=http://192.168.37.14:2386,infra4-5=http://192.168.37.14:2388,infra4-6=http://192.168.37.14:2390,infra4-7=http://192.168.37.14:2392,infra5-1=http://192.168.37.15:2380,infra5-2=http://192.168.37.15:2382,infra5-3=http://192.168.37.15:2384,infra5-4=http://192.168.37.15:2386,infra5-5=http://192.168.37.15:2388,infra5-6=http://192.168.37.15:2390,infra5-7=http://192.168.37.15:2392,infra6-1=http://192.168.37.16:2380,infra6-2=http://192.168.37.16:2382,infra6-3=http://192.168.37.16:2384,infra6-4=http://192.168.37.16:2386,infra6-5=http://192.168.37.16:2388,infra6-6=http://192.168.37.16:2390,infra6-7=http://192.168.37.16:2392,infra7-1=http://192.168.37.17:2380,infra7-2=http://192.168.37.17:2382,infra7-3=http://192.168.37.17:2384,infra7-4=http://192.168.37.17:2386,infra7-5=http://192.168.37.17:2388,infra7-6=http://192.168.37.17:2390,infra7-7=http://192.168.37.17:2392,infra8-1=http://192.168.37.18:2380,infra8-2=http://192.168.37.18:2382,infra8-3=http://192.168.37.18:2384,infra8-4=http://192.168.37.18:2386,infra8-5=http://192.168.37.18:2388,infra8-6=http://192.168.37.18:2390,infra8-7=http://192.168.37.18:2392,infra9-1=http://192.168.37.19:2380,infra9-2=http://192.168.37.19:2382,infra9-3=http://192.168.37.19:2384,infra9-4=http://192.168.37.19:2386,infra9-5=http://192.168.37.19:2388,infra9-6=http://192.168.37.19:2390,infra9-7=http://192.168.37.19:2392' --initial-cluster-state new --enable-pprof
