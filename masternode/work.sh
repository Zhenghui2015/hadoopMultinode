#!/bin/bash

cd $HADOOP_PREFIX

echo "Initialize hdfs:"
bin/hdfs dfs -mkdir -p /user/root
bin/hdfs dfs -put bigram .

echo "Original test file:"
bin/hdfs dfs -cat bigram/testFile

echo "Start run wordcount demo:"
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar wordcount bigram/testFile wordCntRes
echo "Result:"
bin/hdfs dfs -cat wordCntRes/part-r-00000

echo "Start run bigram example:"
### run python code
bin/hadoop jar share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar \
-input bigram/testFile -output output \
-file bigram/bigramMapper.py -file bigram/bigramReducer.py -mapper bigram/bigramMapper.py -reducer bigram/bigramReducer.py

bin/hadoop jar ./share/hadoop/tools/lib/hadoop-streaming-2.7.1.jar \
-D mapred.output.key.comparator.class=org.apache.hadoop.mapred.lib.KeyFieldBasedComparator \
-D mapred.text.key.comparator.options=-nr \
-input output/part-00000 -output bigramRes \
-file bigram/sortMapper.py -file bigram/sortReducer.py -mapper bigram/sortMapper.py -reducer bigram/sortReducer.py

echo "Result:"
bin/hdfs dfs -cat bigramRes/part-00000
