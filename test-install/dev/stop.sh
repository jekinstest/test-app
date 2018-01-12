#!/bin/bash

pid_file="config/test.pid"

stop_app() {
	echo "Stopping application... (pid=$1)"
	ps -Af | grep test-be
	kill -9 $1
	echo "Stopped application."	
	ps -Af | grep test-be
}

stop_app_pid() {
	echo "Search pid file... ($1)"
	if [ -s "$1" ] ; then
		echo "Pid file found."
	        local pid=$(head -1 "$1")
        	stop_app "${pid}"

	else
		echo "Pid file not found."
	fi
}


if [ $# -eq 2 ] ; then
	if [ "$1" == "-p" ] ; then
		stop_app $2
	else
		if [ "$1" == "-f" ]; then
			stop_app_pid $2
		fi
	fi
else        
	stop_app_pid ${pid_file}

fi

