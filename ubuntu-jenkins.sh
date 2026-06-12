#!/bin/bash

# Update Ubuntu package index from configured repositories
sudo apt update

# Install required packages:
# curl  -> download files from URLs
# gnupg -> manage and verify GPG signing keys
# openjdk-21-jdk -> Java 21 required by Jenkins
sudo apt install -y curl gnupg openjdk-21-jdk

# Remove any old Jenkins repository configuration
# Prevents conflicts with previous Jenkins installations
sudo rm -f /etc/apt/sources.list.d/jenkins.list

# Remove old Jenkins signing keys if they exist
# Useful when rerunning the script or upgrading keys
sudo rm -f /usr/share/keyrings/jenkins-keyring.asc
sudo rm -f /usr/share/keyrings/jenkins-keyring.gpg

# Download the current Jenkins repository signing key
# APT uses this key to verify Jenkins packages are authentic
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \
| sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add the Jenkins package repository
# signed-by tells APT which key to use when validating packages
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
| sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Refresh package index again
# Loads package information from the newly added Jenkins repository
sudo apt update

# Install Jenkins from the Jenkins repository
sudo apt install -y jenkins

# Enable Jenkins service to start automatically after reboot
sudo systemctl enable jenkins

# Start Jenkins service immediately
sudo systemctl start jenkins

# Display Jenkins service status
# Confirms whether Jenkins started successfully
sudo systemctl status jenkins --no-pager

# Displays Initial Password
cat /var/lib/jenkins/secrets/initialAdminPassword

#NOTE: 
# 1) ENABLE JAVA VERSION (optional if you want to pick between versions)
     #sudo update-alternatives --config java
# 2) Use ubuntu 22.04 LTS      


