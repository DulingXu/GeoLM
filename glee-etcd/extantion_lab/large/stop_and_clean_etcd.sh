#!/bin/bash
# set -euo pipefail

# 定义容器名称
CONTAINERS=("glee1" "glee2" "glee3" "glee4" "glee5" "glee6" "glee7" "glee8" "glee9")

# 停止容器中的glee-etcd进程
for container in ${CONTAINERS[@]} 
do
  docker exec ${container} pkill etcd
done 

# 解除端口绑定
for container in ${CONTAINERS[@]}
do
  # 检查2380端口
  PID=$(docker exec $container lsof -ti :2380)
  if [ ! -z "$PID" ]; then
    docker exec ${container} kill ${PID}
  fi

  # 检查2379端口
  PID=$(docker exec $container lsof -ti :2379)
  if [ ! -z "$PID" ]; then  
    docker exec ${container} kill ${PID}
  fi
done

# 清空etcd数据目录
for container in ${CONTAINERS[@]}
do
  # docker exec ${container} kill -9 `pidof glee-etcd`
  echo ${container}
  docker exec ${container} rm -rf /expr/data*
  docker exec ${container} rm -rf /expr/data1
  docker exec ${container} rm -rf /expr/data2
  docker exec ${container} rm -rf /expr/data3
  docker exec ${container} rm -rf /expr/data4
  docker exec ${container} rm -rf /expr/data5
  docker exec ${container} rm -rf /expr/data6
  docker exec ${container} rm -rf /expr/data7
done
