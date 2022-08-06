#!/bin/bash

echo "Install node_exporter (semua target worker)"
echo
curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -
 tar -xvf node_exporter*.tar.gz
 cd  node_exporter*/
 cp node_exporter /usr/local/bin
 cp node_exporter /usr/bin
clear
echo
echo
echo "cek instalasi node exporter.."
 node_exporter --version
echo
echo
echo "Menambahkan file konfigurasi ke node_exporter.service"
echo
sudo tee /etc/systemd/system/node_exporter.service<<EOF
 ::tambahkan file berikut:
 [Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter \
    --collector.cpu \
    --collector.diskstats \
    --collector.filesystem \
    --collector.loadavg \
    --collector.meminfo \
    --collector.filefd \
    --collector.netdev \
    --collector.stat \
    --collector.netstat \
    --collector.systemd \
    --collector.uname \
    --collector.vmstat \
    --collector.time \
    --collector.mdadm \
    --collector.zfs \
    --collector.tcpstat \
    --collector.bonding \
    --collector.hwmon \
    --collector.arp \
    --web.listen-address=:9100 \
    --web.telemetry-path="/metrics"

[Install]
WantedBy=multi-user.target
EOF
echo
clear
echo
echo "Cek status node exporter"
echo
useradd -rs /bin/false node_exporter
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
systemctl status node_exporter
echo
echo
