#!/bin/bash

set -e

echo "Updating server..."
sudo apt update -y

echo "Installing required packages..."
sudo apt install -y wget tar

cd /opt

NEXUS_VERSION="3.93.0-06"

echo "Downloading Nexus..."
sudo wget https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-linux-x86_64.tar.gz

echo "Extracting Nexus..."
sudo tar -xzf nexus-${NEXUS_VERSION}-linux-x86_64.tar.gz

NEXUS_DIR=$(ls -d nexus-* | head -1)

sudo mv $NEXUS_DIR nexus

echo "Creating nexus user..."
sudo useradd -r -m -d /opt/nexus -s /bin/bash nexus || true

echo "Setting ownership..."
sudo chown -R nexus:nexus /opt/nexus

if [ -d /opt/sonatype-work ]; then
    sudo chown -R nexus:nexus /opt/sonatype-work
fi

echo "Configuring Nexus user..."
sudo sed -i 's/#run_as_user=""/run_as_user="nexus"/' /opt/nexus/bin/nexus.rc

echo "Creating systemd service..."

sudo tee /etc/systemd/system/nexus.service > /dev/null <<EOF
[Unit]
Description=Nexus Repository Manager
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

echo "Reloading systemd..."
sudo systemctl daemon-reload

echo "Enabling Nexus..."
sudo systemctl enable nexus

echo "Starting Nexus..."
sudo systemctl start nexus

echo "Checking status..."
sudo systemctl status nexus --no-pager

echo "Installation completed."
echo "Access Nexus at:"
echo "http://<SERVER-IP>:8081"
