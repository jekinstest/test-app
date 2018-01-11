#!/bin/bash

java_app="/opt/test/test-be-*.jar"
out_log="/opt/test/logs/out.log"
err_log="/opt/test/logs/err.log"
pid_file="/opt/test/config/test.pid"

echo "Start application..."

export _JAVA_OPTIONS=-Djava.io.tmpdir=/opt/test/tmp

nohup java -jar ${java_app} > ${out_log} 2>${err_log} --spring.config.location=/opt/test/config/application.properties &
echo $! > ${pid_file}

echo "See the logs/out.log file"
ps -Af | grep test-be

