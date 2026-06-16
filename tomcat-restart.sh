#!/bin/bash
# Stop Tomcat
sh /opt/tomcat/bin/shutdown.sh

echo "======================================================================"
echo "===================== Wait 15s ======================================="
echo "======================================================================"

# Wait for Tomcat to fully stop
sleep 10

# Start Tomcat
sh /opt/tomcat/bin/startup.sh

echo "Tomcat Successfully Restarted"
