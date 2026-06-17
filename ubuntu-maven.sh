#!/bin/bash

set -e

echo "Updating package repository..."
sudo apt update -y
sudo apt upgrade -y 

echo "Installing Java 17"
sudo apt install openjdk-17-jdk -y

echo "Installing maven"  
sudo apt install maven -y
  
echo "Verifying Java installation..."
java -version

echo "Verifying Maven installation..."
mvn -version

echo "Maven installation completed successfully."
