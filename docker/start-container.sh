#!/bin/bash

# the default node number is 2
N=${1:-2}

# create hadoop network
if ! docker network inspect hadoop > /dev/null ;
then
    echo "create hadoop network"
    docker network create --driver bridge hadoop
fi

# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
                    --net hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                ffminx/hadoop:1.0 &> /dev/null
	i=$(( $i + 1 ))
done

# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 9000:9000 \
                -p 8030:8030 \
                -p 8031:8031 \
                -p 8032:8032 \
                --name hadoop-master \
                --hostname hadoop-master \
                ffminx/hadoop:1.0 &> /dev/null

# get into hadoop master container
 sudo docker exec -it hadoop-master /bin/bash

