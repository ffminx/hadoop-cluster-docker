#!/bin/bash

# test the hadoop cluster by running single table join
basepath=$(cd `dirname $0`; pwd)

# create input directory on HDFS
hadoop fs -rm -r -f singleTableJoinInput
hadoop fs -mkdir -p singleTableJoinInput

# put input files to HDFS
hdfs dfs -put ${basepath}/input/* singleTableJoinInput

# clean output
hadoop fs -rm -r -f singleTableJoinOutput

# run single table join
hadoop jar ${basepath}/singleTableJoin.jar zh.ffminx.hadoop.SingleTableJoin singleTableJoinInput singleTableJoinOutput

# print the input files
echo -e "\ninput:"
hdfs dfs -cat singleTableJoinInput/input.txt

# print the output of single table output
echo -e "\nsingleTableJoin output:"
hdfs dfs -cat singleTableJoinOutput/part-r-00000

