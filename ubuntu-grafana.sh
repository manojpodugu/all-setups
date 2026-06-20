#GRAFANA
set -e

echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

echo "Installing prerequisites..."
sudo apt install -y curl unzip tar

sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_9.4.7_amd64.deb
sudo dpkg -i grafana-enterprise_9.4.7_amd64.deb
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable grafana-server
sudo /bin/systemctl start grafana-server
sudo /bin/systemctl status grafana-server --no-pager

echo "--------------------------------------------------------------------------------------------------"
echo "============================= Grafana Installation completed successfully.======================"
echo "--------------------------------------------------------------------------------------------------"
