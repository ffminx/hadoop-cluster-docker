#!/bin/bash

# test the hadoop cluster by running delete repeat record

# create input directory on HDFS
hadoop fs -rm -r -f deleteRepeatRecordInput
hadoop fs -mkdir -p deleteRepeatRecordInput

# put input files to HDFS
hdfs dfs -put ./input/* deleteRepeatRecordInput

# clean output
hadoop fs -rm -r -f deleteRepeatRecordOutput

# run delete repeat record
hadoop jar ./deleteRepeatRecord.jar deleteRepeatRecordInput deleteRepeatRecordOutput

# print the input files
echo -e "\ninput file1.txt:"
hdfs dfs -cat deleteRepeatRecordInput/file1.txt

echo -e "\ninput file2.txt:"
hdfs dfs -cat deleteRepeatRecordInput/file2.txt

# print the output of delete repeat record
echo -e "\ndelete repeat record output:"
hdfs dfs -cat deleteRepeatRecordOutput/part-r-00000

