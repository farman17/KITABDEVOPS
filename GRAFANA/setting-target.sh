#!/bin/bash
clear
echo "Setting target untuk node yang ingin di monitoring di prometheus:"
echo
echo -n "masukkan IP Node yang ingin di pantau: ";
read ipnode;
echo
sed -i '$ a\ ' /etc/prometheus/prometheus.yml
sed -i '$ a\  - job_name: node_exporter_server_monitoring' /etc/prometheus/prometheus.yml
sed -i '$ a\    static_configs:' /etc/prometheus/prometheus.yml 
sed -i '$ a\      - targets: ['$ipnode:9100']' /etc/prometheus/prometheus.yml
echo
systemctl restart prometheus
echo "SELESAI..."
