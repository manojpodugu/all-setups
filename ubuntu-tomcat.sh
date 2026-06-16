#!/bin/bash

set -e

apt update -y
apt install openjdk-17-jdk wget -y

TOMCAT_VERSION=10.1.55

cd /opt

echo "Downloading Tomcat..."
wget https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

echo "Extracting..."
tar -xvzf apache-tomcat-${TOMCAT_VERSION}.tar.gz

mv apache-tomcat-${TOMCAT_VERSION} tomcat
# ---------------------------
# FIX: Proper ownership & permissions (CRITICAL FIX)  # use if necessary.
# ---------------------------
#echo "Setting permissions..."
#chown -R root:root /opt/tomcat
#chmod -R 755 /opt/tomcat
#chmod -R 755 /opt/tomcat/webapps

# ---------------------------
# 1. Add users dynamically. You are: Adding role: manager-gui, Adding role: manager-script, Creating user: admin, Giving that user permissions
# ---------------------------
TOMCAT_USERS="/opt/tomcat/conf/tomcat-users.xml"

# Insert roles before closing tag
sed -i '/<\/tomcat-users>/ i \
<role rolename="manager-gui"/>\n\
<role rolename="manager-script"/>\n\
<user username="admin" password="sai123" roles="manager-gui,manager-script"/>' \
$TOMCAT_USERS
# Remove restrictive Valve entry
echo "=============== Removing "<Valve className="org.apache.catalina.valves.RemoteCIDRValve"
         allow="127.0.0.0/8,::1/128" /> "================================================ "
         
sed -i '/<Valve className="org.apache.catalina.valves.RemoteAddrValve"/,/\/>$/d' /opt/tomcat/webapps/manager/META-INF/context.xml
echo " updated "/opt/tomcat/webapps/manager/META-INF/context.xml""
chmod +x /opt/tomcat/bin/*.sh

echo "Starting Tomcat..."
/opt/tomcat/bin/startup.sh

echo "SUCCESS 🚀"
echo "Open: http://<EC2-PUBLIC-IP>:8080"
