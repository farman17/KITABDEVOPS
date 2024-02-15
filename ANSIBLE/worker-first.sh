#!/bin/bash
clear
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
apt-get update
clear
sudo apt install -y ansible
#apt-get install python3 ansible
clear

echo -n "masukkan username baru-ansible: ";
read username;
adduser $username
usermod -aG sudo $username

runuser -l  $username  -c  'sudo ssh-keygen -t rsa'
runuser -l  $username  -c  'sudo chmod 400 /root/.ssh/id_rsa'
#sudo ssh-keygen -t rsa
#cd /root/.ssh
#sudo chmod 400 id_rsa

echo -n "masukkan domain dest-host: ";
read host1;
echo -n "masukkan IP dest-host: ";
read ip1;
echo -n "masukkan username dest-host: ";
read user1;
