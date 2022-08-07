#!/bin/bash
clear

echo "Add Blackbox exporter (WORKER ONLY)"
sudo useradd -M -r -s /bin/false blackbox
curl -s https://api.github.com/repos/prometheus/blackbox_exporter/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -

tar xvzf blackbox_exporter-*.linux-amd64.tar.gz
cd blackbox_exporter-*.linux-amd64
sudo cp blackbox_exporter /usr/local/bin
echo
echo
echo "Cek versi blackbox_Exporter:"
echo
blackbox_exporter --version
echo
sudo chown blackbox:blackbox /usr/local/bin/blackbox_exporter
cd ~/blackbox_exporter-*.linux-amd64
sudo mkdir -p /etc/blackbox
sudo cp blackbox.yml /etc/blackbox
sudo chown -R blackbox:blackbox /etc/blackbox/*
echo
echo "Install blackbox_Exporter Selessai..."
