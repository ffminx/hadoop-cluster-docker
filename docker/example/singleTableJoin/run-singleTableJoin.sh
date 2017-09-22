#!/bin/bash

# test the hadoop cluster by running single table join

# create input directory on HDFS
hadoop fs -mkdir -p singleTableJoinInput

# put input files to HDFS
hdfs dfs -put ./input/* singleTableJoinInput

hadoop fs -rm -r -f singleTableJoinOutput
# run wordcount 
hadoop jar ./singleTableJoin.jar singleTableJoinInput singleTableJoinOutput

# print the input files
echo -e "\ninput:"
hdfs dfs -cat singleTableJoinInput/input.txt

# print the output of single table output
echo -e "\nsingleTableJoin output:"
hdfs dfs -cat singleOutput/part-r-00000

