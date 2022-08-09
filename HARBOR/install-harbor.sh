#!/bin/bash
clear

echo "INSTALL HARBOR"
echo
sudo apt update
echo
clear
wget https://github.com/goharbor/harbor/releases/download/v2.4.1/harbor-offline-installer-v2.4.1.tgz
tar -xvzf harbor-offline-installer-v2.4.1.tgz
cd harbor
cp harbor.yml.tmpl harbor.yml
