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
echo "***SELESAI Install Prometehus, next install GRAFANA***"
echo
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
