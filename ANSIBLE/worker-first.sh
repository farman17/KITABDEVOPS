#!/bin/bash
clear
apt-get update
echo "install open ssh untuk remote"
apt install openssh-server
#sudo apt install -y software-properties-common
#sudo add-apt-repository --yes --update ppa:ansible/ansible
#clear
#sudo apt install -y ansible
clear

echo -n "masukkan username baru-ansible: ";
read username;
adduser $username
usermod -aG sudo $username

runuser -l  $username  -c  'sudo ssh-keygen -t rsa'
runuser -l  $username  -c  'sudo chmod 400 /root/.ssh/id_rsa'

sudo ssh-keygen -t rsa
cd /root/.ssh
sudo chmod 400 id_rsa
echo "%sudo  ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "DONE"
