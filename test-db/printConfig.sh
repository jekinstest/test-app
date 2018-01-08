#!/bin/bash

msg_usage="Usage: ./printConfig.sh <<config file path>>"

if [ "$#" -ne 1 ]
then
	echo $msg_usage
	exit
fi

conf=$1

while read -r line
do
	if [[ $line =~ ^#.*$ ]] || [[ $line =~ ^[[:space:]]*$ ]]
	then
		continue
	fi
	echo $line
done < $conf
