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
#echo "menambahkan target IP di prometheus/ jika mau menambahkan manual di /etc/prometheus/prometheus.yml...."
#echo
#sudo tee /etc/prometheus/prometheus.yml<<EOF
#- job_name: 'node_exporter_server_monitoring'
#    static_configs:
#      - targets: ['203.194.112.227:9100']
#EOF
echo
echo "Done..Access Prometheus Dashboard using the server IP or hostname and port 9090"
echo
echo
echo
jawaban="Y"
jawabanlain="y"
read -p "apakah anda ingin melanjutkan instalasi? (y/n)" pilih;
if [ $pilih = $jawaban ] || [ $pilih = $jawabanlain ];
then
clear
echo "***Install GRAFANA***"
echo
sudo apt update
sudo apt-get install -y gnupg2 curl software-properties-common
curl https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt-get update
echo
echo
echo "Instalasi dimulai......"
echo
sudo apt-get -y install grafana
sudo systemctl enable --now grafana-server
systemctl restart grafana-server.service
echo
clear
echo "cek status grafana.."
echo
systemctl status grafana-server.service 
echo
echo "Done..Access Grafana Dashboard using the server IP or hostname and port 3000"
echo
exit 0
else
echo
echo "Installasi dibatalkan, terimakasih sudah menggunakan aplikasi kami"
echo
exit 1
fi
echo
