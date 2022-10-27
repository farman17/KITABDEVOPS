#!/bin/bash
clear
echo
echo
echo "**Install node_exporter (semua target worker)**"
echo "#ini merupakan prototype dari file dashboard-monitoring-server.sh dimana pada file ini sudah tidak lagi menggunakan node_exporter, karena node exporter telah di install terpisah di server menggunakan ANSIBLE"
echo
echo
echo "Cek status node exporter"
echo
useradd -rs /bin/false node_exporter
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
systemctl status node_exporter
echo 
echo "SELESAI....."

