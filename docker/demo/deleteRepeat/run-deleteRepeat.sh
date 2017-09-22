#!/bin/bash

# test the hadoop cluster by running wordcount

# create input directory on HDFS
hadoop fs -mkdir -p input2

# put input files to HDFS
hdfs dfs -put ./deleteRepeat/* input2

hadoop fs -rm -r -f output2
# run wordcount 
hadoop jar ./deleteRepeat.jar input2 output2

# print the input files
echo -e "\ninput file1.txt:"
hdfs dfs -cat input2/file1

echo -e "\ninput file2.txt:"
hdfs dfs -cat input2/file2

# print the output of wordcount
echo -e "\nwordcount output:"
hdfs dfs -cat output2/part-r-00000

