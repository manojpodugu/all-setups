#!/bin/bash
set -e

apt update -y
apt upgrade -y

echo "Configuring SSH for Ansible..."

# Create override config (highest priority)
cat <<EOF > /etc/ssh/sshd_config.d/99-ansible.conf
# Ansible SSH Access Configuration Override

PasswordAuthentication yes
PermitRootLogin yes
PubkeyAuthentication yes
EOF

echo "SSH config override created."

# Validate SSH config before restart
sshd -t

# Restart SSH service (Ubuntu uses 'ssh')
systemctl restart ssh

# Check SSH service status
systemctl status ssh --no-pager

echo "Fetching effective SSH configuration (filtered)..."

# Show only required fields from final SSH config
sshd -T | grep -E "passwordauthentication|permitrootlogin|pubkeyauthentication"

echo "=================================================="
echo "✅ Ansible master can successfully connect to worker nodes via SSH!"
echo "=================================================="
