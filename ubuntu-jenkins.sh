#!/bin/bash

# STEP-1: INSTALLING GIT, JAVA 17 (Ubuntu doesn't support Java 1.8 well anymore), MAVEN
sudo apt update
sudo apt install -y git openjdk-17-jdk maven

# STEP-2: ADD JENKINS REPO
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# STEP-3: INSTALL JENKINS
sudo apt update
sudo apt install -y jenkins

# STEP-4: ENABLE JAVA VERSION (optional if you want to pick between versions)
#sudo update-alternatives --config java

# STEP-5: START AND ENABLE JENKINS
sudo systemctl start jenkins
sudo systemctl enable jenkins

# STEP-6: SHOW STATUS
sudo systemctl status jenkins
