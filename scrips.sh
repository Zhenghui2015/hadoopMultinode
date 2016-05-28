#!/bin/bash
echo ""
echo ""
echo "Create master node image and client node image"
echo ""
echo ""

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
echo "wait for initializing 1 master node and 4 cluster nodes..."
echo "it may take a while, please wait..."
echo ""
echo ""

sleep 50

echo "Hadoop multicluster report:"
docker exec -it master /bin/bash /usr/local/hadoop/bin/hdfs dfsadmin -report

#echo "Initialize hdfs:"
docker exec -it master /bin/bash $HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root

### Now bigram directory should already in master node
### suppose now I can run in a iteractive environment
# docker exec -it master /bin/bash
# cd $HADOOP_PREFIX
# $HADOOP_PREFIX/bin/hdfs dfs -put testFile

#### suppose *.py in current directory

echo "Original test file:"
#$HADOOP_PREFIX/bin/hdfs dfs -cat testFile

echo "Start run wordcount demo:"
#bin/hadoop jar ./share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar wordcount testFile wordCntRes
echo "Result:"
#$HADOOP_PREFIX/bin/hdfs dfs -cat wordCntRes/part-00000 

echo "Start run bigram example:"
### run python code
#bin/hadoop jar ./share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar \
# -input testFile -output output -file bigramMapper.py -file bigramReducer.py -mapper bigramMapper.py -reducer bigramReducer.py
#bin/hadoop jar ./share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar \
# -D mapred.output.key.comparator.class=org.apache.hadoop.mapred.lib.KeyFieldBasedComparator \
# -D  mapred.text.key.comparator.options=-nr \
# -input output/part-00000 -output bigramRes \
# -file sortMapper.py -file sortReducer.py -mapper sortMapper.py -reducer sortReducer.py
echo "Result:"
#$HADOOP_PREFIX/bin/hdfs dfs -cat bigramRes/part-00000 

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
