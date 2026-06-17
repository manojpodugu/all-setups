#!/bin/bash

set -e
# Stop Tomcat
sh /root/tomcat/bin/shutdown.sh

echo "======================================================================"
echo "===================== Wait 15s ======================================="
echo "======================================================================"

# Wait for Tomcat to fully stop
sleep 10

# Start Tomcat
sh /root/tomcat/bin/startup.sh

echo "Tomcat Successfully Restarted"
