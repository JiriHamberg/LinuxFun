#! /bin/bash

host=$1
command=$2
result=$(ssh $host $command)
echo "Host $host returned $result"
