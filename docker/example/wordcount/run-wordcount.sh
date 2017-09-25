#!/bin/bash

# test the hadoop cluster by running wordcount

# create input files 

# create input directory on HDFS
hadoop fs -rm -r -f wordCountInput
hadoop fs -mkdir -p wordCountInput

# put input files to HDFS
hdfs dfs -put ./input/* wordCountInput

hadoop fs -rm -r -f wordCountOutput

# run wordcount 
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/sources/hadoop-mapreduce-examples-2.7.2-sources.jar org.apache.hadoop.examples.WordCount wordCountInput wordCountOutput

# print the input files
echo -e "\ninput file1.txt:"
hdfs dfs -cat wordCountInput/file1.txt

echo -e "\ninput file2.txt:"
hdfs dfs -cat wordCountInput/file2.txt

# print the output of wordcount
echo -e "\nwordcount output:"
hdfs dfs -cat wordCountOutput/part-r-00000

