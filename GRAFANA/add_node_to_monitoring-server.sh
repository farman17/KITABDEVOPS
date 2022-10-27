#!/bin/bash
clear
echo
echo
echo "**Install node_exporter (semua target worker)**"
echo "#ini merupakan prototype dari file dashboard-monitoring-server.sh dimana pada file ini sudah tidak lagi menggunakan node_exporter, karena node exporter telah di install terpisah di server menggunakan ANSIBLE"
echo
echo "cek instalasi node exporter.."
 node_exporter --version
echo
echo
echo
echo "Menambahkan file konfigurasi ke node_exporter.service"
echo
sudo tee /etc/systemd/system/node_exporter.service<<EOF
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
sed -i '$ a\ ' /etc/prometheus/prometheus.yml
sed -i '$ a\  - job_name: jobname' /etc/prometheus/prometheus.yml
sed -i '$ a\    static_configs:' /etc/prometheus/prometheus.yml 
sed -i '$ a\      - targets: [ippantau:9100]' /etc/prometheus/prometheus.yml
echo
echo "Setting target untuk node yang ingin di monitoring di prometheus:"
echo -n "masukkan Jobname : ";
read jobname;
echo
echo -n "masukkan IP Node yang ingin di pantau: ";
read ippantau;
sed -ie 's/jobname/'$jobname'/g' /etc/prometheus/prometheus.yml
sed -ie 's/ippantau/'$ippantau'/g' /etc/prometheus/prometheus.yml  
systemctl restart prometheus
echo "SELESAI....."
echo
echo "Akses ke GRAFANA Dashboard lalu klik icon “+” dan klik import, setelah itu pada bagian import via grafana.com isi 11074 atau 1860, dimana ini adalah code untuk template monitoring serv"
