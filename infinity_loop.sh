#!/bin/bash
while :
do
    echo "Press [CTRL+C] to stop.."
#    for pid in $(ps -ef | awk '/your process name/ {print $2}'); do kill -9 $pid; done  
 ls -l | wc
    
   # sleep 1
done