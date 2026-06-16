#!/bin/bash

sudo apt update -y
sudo -e
sudo apt install openjdk-17-jdk -y

cd /opt
sudo wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.43/bin/apache-tomcat-10.1.43.tar.gz

sudo tar -xzf apache-tomcat-10.1.43.tar.gz
sudo mv apache-tomcat-10.1.43 tomcat

sudo chmod +x /opt/tomcat/bin/*.sh

/opt/tomcat/bin/startup.sh
