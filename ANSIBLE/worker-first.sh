#!/bin/bash
clear
echo "UPDATE SYSTEM......."
figlet DEVOPS
apt-get update
clear
echo "install open ssh untuk remote"
apt install openssh-server
clear

echo -n "masukkan username baru-ansible: ";
read username;
adduser $username
usermod -aG sudo $username

runuser -l  $username  -c  'sudo ssh-keygen -t rsa'
runuser -l  $username  -c  'sudo chmod 400 /root/.ssh/id_rsa'

clear
echo "add keygen to .ssh"
sudo ssh-keygen -t rsa
cd /root/.ssh
sudo chmod 400 id_rsa
echo
echo
#echo "add NOPASSWORDD to root........"
#echo "%sudo  ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers    
echo "DONE, THANKYOU......."
