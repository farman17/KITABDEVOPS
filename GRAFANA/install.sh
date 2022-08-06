#!/bin/bash
clear

echo "Installing Prometheus (server only)"
sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
sudo mkdir /var/lib/prometheus
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done
clear
echo "update system..."
echo
sudo apt update
clear
echo "starting Install Prometheus..."
echo
sudo apt -y install wget curl
mkdir -p /tmp/prometheus && cd /tmp/prometheus
curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -

tar xvf prometheus*.tar.gz
cd prometheus*/
sudo mv prometheus promtool /usr/local/bin/
clear
echo "cek instalasi prometeheus.."
echo
prometheus --version
promtool --version
echo

sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo mv consoles/ console_libraries/ /etc/prometheus/
cd $HOME
echo
echo
echo "Configuring Prometheus (server only)"
echo
sudo nano /etc/hosts
echo
echo "tee ke folder /etc/systemd/system/prometheus.service untuk manage Prometheus service with systemd"
echo
sudo tee /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP \$MAINPID
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
EOF
echo
echo "edit file berikut, sesuaikan ip nya master di baris terakhir:"
echo
echo "Change directory permissions folder /etc/prometheus/---->"
sudo chown -R prometheus:prometheus /etc/prometheus/
sudo chmod -R 775 /etc/prometheus/
sudo chown -R prometheus:prometheus /var/lib/prometheus/
echo
echo
clear
echo "cek status prometheus"
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
clear
sudo systemctl status prometheus
echo

echo
exit 0
else
echo
echo "Installasi dibatalkan, terimakasih sudah menggunakan aplikasi kami"
echo
exit 1
fi
echo
