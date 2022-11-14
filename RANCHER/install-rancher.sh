#!/bin/bash
clear
echo
echo
echo "**Install RANCHER Versi 2.4.18 di cloud**"
echo
docker run -d --name=rancher-server --restart=unless-stopped -p 3001:80 -p 443:443 --privileged rancher/rancher:v2.4.18
echo
clear
echo "Cek Installasi apakah image rancher sudah ter-pull dan running di docker :"
echo
docker ps
echo
echo
echo "SELESAI....."

#sumber : https://www.linuxtechi.com/how-to-install-rancher-on-ubuntu/
#another ref :https://linuxhint.com/install_rancher_ubuntu_docker_containers/
