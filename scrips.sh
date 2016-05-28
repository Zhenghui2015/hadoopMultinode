#!/bin/bash
echo ""
echo ""
echo "Create master node image"
echo ""
echo ""

cd masternode
docker build -t project3/masternode .
cd ..

echo ""
echo ""
echo "Create client node image"
echo ""
echo ""
cd clientnode
docker build -t project3/datanode .

echo ""
echo ""
echo "wait for initializing 1 master node and 4 cluster nodes..."
echo "it may take a while, please wait..."
echo ""
echo ""
docker network create mynetwork
docker run -itd --net=mynetwork -h master --name master project3/masternode /etc/bootstrap.sh -bash
docker run -itd --net=mynetwork -h data1 --name data1 project3/datanode /etc/bootstrap.sh -d
docker run -itd --net=mynetwork -h data2 --name data2 project3/datanode /etc/bootstrap.sh -d
docker run -itd --net=mynetwork -h data3 --name data3 project3/datanode /etc/bootstrap.sh -d
docker run -itd --net=mynetwork -h data4 --name data4 project3/datanode /etc/bootstrap.sh -d

sleep 50

echo ""
echo ""
echo "Hadoop multicluster report:"
docker exec -it master /bin/bash /usr/local/hadoop/bin/hdfs dfsadmin -report

docker exec -it master /bin/bash /usr/local/hadoop/work.sh


docker stop data1
docker stop data2
docker stop data3
docker stop data4
docker stop master

docker rm data1
docker rm data2
docker rm data3
docker rm data4
docker rm master

docker network rm mynetwork
