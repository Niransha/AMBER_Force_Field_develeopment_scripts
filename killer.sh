#!/bin/bash
while :
do
    echo "Press [CTRL+C] to stop.."
    for pid in $(ps -ef | awk '/pmemd.cuda/ {print $2}'); do kill -9 $pid; done  
    
    sleep 1
done