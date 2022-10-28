#!/bin/bash

sudo nano /etc/hostname
sudo nano /etc/hosts
echo "hostname untuk server sudah di ubah"
echo
echo "SET USERNAME UNTUK INSTALL ANSIBLE" 
echo -n "masukkan username baru : ";      
read username;
echo
adduser $username
usermod -aG sudo $username

clear
apt-get update
clear
apt-get install python3 ansible
echo
echo
clear
echo "DONE....."
echo
echo "silahkan login root dan create ssh : ssh-keygen -t rsa"
echo
echo " lalu berikan akses : chmod 400 id_rsa "
echo
su - $username
echo
