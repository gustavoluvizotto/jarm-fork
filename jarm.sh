#!/bin/bash

if [ ! $# -eq 3 ]
    then
    echo "Three arguments required: (1) a list of IPs/domains in a"
    echo "file, separated by line, (2) an output file name and, (3) the port number."
    echo "Example: ./jarm.sh alexa500.txt jarm_alexa_500.csv 443"
    exit 1
 fi

input=$1
port=$3
N=40
(
while IFS= read -r line
do
  ((i=i%N)); ((i++==0)) && wait
  python3 jarm.py $line -p $port -v -o $2 &
done < "$input"
)
wait
