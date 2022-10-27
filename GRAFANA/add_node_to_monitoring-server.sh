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
