echo "----------glee7----------"
# 进入 glee6 容器
sudo docker exec -i glee6 /bin/bash -c '
ping 192.168.37.18 -c4
ping 192.168.37.19 -c4
'
echo "----------glee8----------"
# 进入 glee6 容器
sudo docker exec -i glee6 /bin/bash -c '
ping 192.168.37.19 -c4
'





echo "----------glee1----------"
# 进入 glee1 容器
sudo docker exec -i glee1 /bin/bash -c '
ping 192.168.37.12 -c4
ping 192.168.37.13 -c4
ping 192.168.37.14 -c4
ping 192.168.37.15 -c4
ping 192.168.37.16 -c4
ping 192.168.37.17 -c4
'
echo "----------glee2----------"
# 进入 glee2 容器
sudo docker exec -i glee2 /bin/bash -c '
ping 192.168.37.13 -c4
ping 192.168.37.14 -c4
ping 192.168.37.15 -c4
ping 192.168.37.16 -c4
ping 192.168.37.17 -c4
'
echo "----------glee3----------"
# 进入 glee3 容器
sudo docker exec -i glee3 /bin/bash -c '
ping 192.168.37.14 -c4
ping 192.168.37.15 -c4
ping 192.168.37.16 -c4
ping 192.168.37.17 -c4
'
echo "----------glee4----------"
# 进入 glee4 容器
sudo docker exec -i glee4 /bin/bash -c '
ping 192.168.37.15 -c4
ping 192.168.37.16 -c4
ping 192.168.37.17 -c4
'
echo "----------glee5----------"
# 进入 glee5 容器
sudo docker exec -i glee5 /bin/bash -c '
ping 192.168.37.16 -c4
ping 192.168.37.17 -c4
'
echo "----------glee6----------"
# 进入 glee6 容器
sudo docker exec -i glee6 /bin/bash -c '
ping 192.168.37.17 -c4
'



