#!/bin/bash

set -e

# Install Java
sudo yum install java-17-amazon-corretto -y

# Download Tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.105/bin/apache-tomcat-9.0.105.tar.gz -P /root/

# Go to root directory
cd /root/

# Extract Tomcat
tar -zxvf apache-tomcat-9.0.105.tar.gz

# Rename Tomcat directory
mv apache-tomcat-9.0.105 tomcat

# Add tomcat users and roles
sed -i '/<\/tomcat-users>/ i\ <role rolename="manager-gui"/>\n<role rolename="manager-script"/>\n<user username="tomcat" password="raham123" roles="manager-gui, manager-script"/>' /root/tomcat/conf/tomcat-users.xml

# Remove restrictive Valve entry
sed -i '/<Valve className="org.apache.catalina.valves.RemoteAddrValve"/,/\/>$/d' /root/tomcat/webapps/manager/META-INF/context.xml

# Start Tomcat
nohup /root/tomcat/bin/startup.sh &
