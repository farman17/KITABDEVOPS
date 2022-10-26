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



#source references :
#https://www.cyberithub.com/how-to-install-harbor-on-ubuntu-20-04-lts-step-by-step/
