#!/bin/bash

set -e

echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

echo "Installing prerequisites..."
sudo apt install -y curl unzip tar

echo "Installing AWS CLI v2..."
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install

aws --version
