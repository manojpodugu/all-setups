#!/bin/bash

set -e

# Update system

sudo apt update -y

sudo apt upgrade -y

# Install required packages
sudo apt install -y gnupg software-properties-common wget curl

# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Add HashiCorp repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package index
sudo apt update -y

# Install Terraform
sudo apt install -y terraform

# Verify installation
terraform version

echo "------------------------------------------------- Terraform Installed successfully ------------------------------------------------------------------"           
