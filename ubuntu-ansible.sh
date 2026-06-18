#!/bin/bash
set -e

echo "Updating system..."
apt update && apt upgrade -y

echo "Installing Ansible"
sudo apt install ansible -y

echo "Done on Ansible control node"
ansible --version

echo "======================================================== Ansible Installed Successfully ================================================================="
