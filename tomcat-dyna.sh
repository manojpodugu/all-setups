#!/bin/bash

set -e

apt update -y
apt install openjdk-17-jdk wget -y

TOMCAT_VERSION=10.1.26

cd /opt

echo "Downloading Tomcat..."
wget https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

echo "Extracting..."
tar -xvzf apache-tomcat-${TOMCAT_VERSION}.tar.gz

mv apache-tomcat-${TOMCAT_VERSION} tomcat

chmod +x /opt/tomcat/bin/*.sh

echo "Starting Tomcat..."
/opt/tomcat/bin/startup.sh

echo "SUCCESS 🚀"
echo "Open: http://<EC2-PUBLIC-IP>:8080"
