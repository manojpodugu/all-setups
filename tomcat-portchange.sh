#!/bin/bash
set -e

NEW_PORT=8888

# " sed -i '/<condition>/ s/<search-pattern>/<replacement>/' <file> " SYNTAX of below command.
sed -i '/protocol="HTTP\/1.1"/ s/port="[0-9]\+"/port="'"$NEW_PORT"'"/' /root/tomcat/conf/server.xml

# Stop Tomcat if installed
if [ -f /root/tomcat/bin/shutdown.sh ]; then
    echo "========================= Tomcat installation found. Stopping Tomcat...================================="
    sh /root/tomcat/bin/shutdown.sh || true
    sleep 5
else
    echo "==================== Tomcat installation not found. Skipping shutdown.sh ================================"
fi

echo "Starting Tomcat..."
sh /root/tomcat/bin/startup.sh

echo "Tomcat Port    : $NEW_PORT"
echo "Manager URL    : http://<SERVER-IP>:$NEW_PORT/manager/html"
echo "=====================TOMCAT RESTARTED AND PORT CHANGED SUCCESSFULLY======================================== "
