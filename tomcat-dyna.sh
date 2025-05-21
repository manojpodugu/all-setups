#!/bin/bash

# Install Java 17
sudo yum install java-17-amazon-corretto -y

# Download and extract Tomcat 9.0.99
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.99/bin/apache-tomcat-9.0.99.tar.gz
tar -zxvf apache-tomcat-9.0.99.tar.gz
mv apache-tomcat-9.0.99 tomcat

# Add Tomcat manager roles and user before the closing </tomcat-users> tag
sed -i '/<\/tomcat-users>/ i\
<role rolename="manager-gui"/>\n<role rolename="manager-script"/>\n<user username="tomcat" password="raham123" roles="manager-gui, manager-script"/>
' tomcat/conf/tomcat-users.xml

# Remove the restrictive Valve entry that limits access to manager web UI & removing this can allow to aceess the application with any IP address(publicly).
sed -i '/<Valve className="org.apache.catalina.valves.RemoteAddrValve"/,/\/>$/d' tomcat/webapps/manager/META-INF/context.xml

# Start Tomcat
sh tomcat/bin/startup.sh
