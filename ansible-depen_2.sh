#!/bin/bash
clear
apt-get update
clear
apt-get install python3 ansible
clear

sudo ssh-keygen -t rsa
cd /root/.ssh
sudo chmod 400 id_rsa

echo -n "masukkan domain dest-host: ";
read host;
echo -n "masukkan IP dest-host: ";
read ip1;
echo -n "masukkan username dest-host: ";
read user1;

echo

echo -n "masukkan domain source-host: ";
read source;
echo -n "masukkan IP dest-host: ";
read ip2;
echo -n "masukkan username source-host: ";
read user2;
clear
tee /etc/ansible/hosts<<EOF
 [$host]
 $ip1     ansible_user=$user1  ansible_ssh_private_key=/root/.ssh/id_rsa 

 [$source]
 $ip2     ansible_user=$user2  ansible_ssh_private_key=/root/.ssh/id_rsa 
EOF
echo
echo
ssh-copy-id $user1@$ip1
echo
echo
ansible $host -m ping
echo
echo "DONE......."
