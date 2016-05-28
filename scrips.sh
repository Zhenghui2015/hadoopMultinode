#!/bin/bash

cd masternode
docker build -t project3/masternode .
cd ..
cd clientnode
docker build -t project3/datanode .


docker network create mynetwork
docker run -itd --net=mynetwork -h master --name master project3/masternode /etc/bootstrap.sh -bash
docker run -itd --net=mynetwork -h data1 --name data1 project3/datanode /etc/bootstrap.sh -d
docker run -itd --net=mynetwork -h data2 --name data2 project3/datanode /etc/bootstrap.sh -d
docker run -itd --net=mynetwork -h data3 --name data3 project3/datanode /etc/bootstrap.sh -d
docker run -itd --net=mynetwork -h data4 --name data4 project3/datanode /etc/bootstrap.sh -d

echo ""
echo ""
echo "wait for initializing..."
echo ""
echo ""

sleep 20
docker exec -it master /bin/bash /usr/local/hadoop/bin/hdfs dfsadmin -report
docker exec -it master /bin/bash$HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root

#docker exec -it master /bin/bash bin/hadoop jar ./share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar wordcount file1 output1
### run python code
#bin/hadoop jar ./share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar -D mapred.reduce.tasks=1 -input file1 -output ouput -file mapper.py -file reducer.py -mapper mapper.py -reducer reducer.py
#$HADOOP_PREFIX/bin/hdfs dfs -rm -r output5

#docker stop data1
#docker stop data2
#docker stop data3
#docker stop data4
#docker stop master

#docker rm data1
#docker rm data2
#docker rm data3
#docker rm data4
#docker rm master

#docker network rm mynetwork
