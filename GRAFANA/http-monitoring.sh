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
echo
echo
echo "Edit file blackbox service"
echo
sudo tee /etc/systemd/system/blackbox.service<<EOF
[Unit]
Description=Blackbox Exporter Service
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=blackbox
Group=blackbox
ExecStart=/usr/local/bin/blackbox_exporter \
  --config.file=/etc/blackbox/blackbox.yml \
  --web.listen-address=":9115"

Restart=always

[Install]
WantedBy=multi-user.target
EOF
echo
clear
echo
sudo systemctl daemon-reload
sudo systemctl enable blackbox
sudo systemctl start blackbox
echo "Cek status blackbox..."
sudo systemctl status blackbox
echo
clear
echo
sed -i '$ a\ ' /etc/prometheus/prometheus.yml
sed -i '$ a\  - job_name: jobname' /etc/prometheus/prometheus.yml
sed -i '$ a\    metrics_path: /probe' /etc/prometheus/prometheus.yml
sed -i '$ a\    params:' /etc/prometheus/prometheus.yml
sed -i '$ a\      module: [http_2xx]' /etc/prometheus/prometheus.yml
sed -i '$ a\    static_configs:' /etc/prometheus/prometheus.yml
sed -i '$ a\      - targets:' /etc/prometheus/prometheus.yml
sed -i '$ a\        - http://ipordns' /etc/prometheus/prometheus.yml
sed -i '$ a\    relabel_configs:' /etc/prometheus/prometheus.yml
sed -i '$ a\      - source_labels: [__address__]' /etc/prometheus/prometheus.yml
sed -i '$ a\        target_label: __param_target' /etc/prometheus/prometheus.yml
sed -i '$ a\      - source_labels: [__param_target]' /etc/prometheus/prometheus.yml
sed -i '$ a\        target_label: instance' /etc/prometheus/prometheus.yml
sed -i '$ a\      - target_label: __address__' /etc/prometheus/prometheus.yml
sed -i '$ a\        replacement: ipserverprometheus:9115' /etc/prometheus/prometheus.yml
echo
clear
echo "***Setting target untuk node yang ingin di monitoring di prometheus:***"
echo
echo -n "masukkan Jobname : ";
read jobname;
echo
echo -n "masukkan IP Node yang ingin di pantau: ";
read ippantau;
echo
echo -n "masukkan IP Server tempat install Prometheus: ";
echo
read ipserverprometheus;
sed -ie 's/jobname/'$jobname'/g' /etc/prometheus/prometheus.yml
sed -ie 's/ippantau/'$ipordns'/g' /etc/prometheus/prometheus.yml
sed -ie 's/ipserverprometheus/'$ipserverprometheus'/g' /etc/prometheus/prometheus.yml

sudo systemctl restart prometheus

echo "SELESAI....."
echo
echo "Akses ke GRAFANA Dashboard lalu klik icon “+” dan klik import, setelah itu pada bagian import via grafana.com isi 7587, dimana ini adalah code untuk template monitoring web
