#!/bin/bash

# test the hadoop cluster by running wordcount

# create input directory on HDFS
hadoop fs -mkdir -p singleTableJoin 

# put input files to HDFS
hdfs dfs -put ./singleTableJoin/* singleTableJoin 

hadoop fs -rm -r -f singleOutput
# run wordcount 
hadoop jar ./singleTableJoin.jar singleTableJoin singleOutput 

# print the input files
echo -e "\ninput file1.txt:"
hdfs dfs -cat singleTableJoin/input.txt

# print the output of wordcount
echo -e "\nsingleTableJoin output:"
hdfs dfs -cat singleOutput/part-r-00000

