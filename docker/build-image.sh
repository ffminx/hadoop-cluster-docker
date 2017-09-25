#!/bin/bash

echo -e "\npackage jar"
cd ../
mvn package

echo -e "\ncopy delete repeat record test jar"
cp ./target/hadoop-cluster-docker-1.0-SNAPSHOT.jar ./docker/example/deleteRepeatRecord/deleteRepeatRecord.jar

echo -e "\ncopy single table join test jar"
cp ./target/hadoop-cluster-docker-1.0-SNAPSHOT.jar ./docker/example/singleTableJoin/singleTableJoin.jar

echo -e "\nbuild docker hadoop image\n"
cd docker
docker build -t ffminx/hadoop:1.0 .

echo -e "\nbuild image success!"