#!/bin/bash
clear
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
#apt-get update
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

echo
clear
tee /etc/ansible/hosts<<EOF
 [$host1]
 $ip1     ansible_user=$user1  ansible_ssh_private_key=/root/.ssh/id_rsa
EOF
echo
echo
ssh-copy-id $user1@$ip1
echo
echo
ansible $host1 -m ping
echo
echo "DONE....ANSIBLE username anda [$username] telah berhasil terkoneksi dengan user $user1 dengan hostname  $host1 dan ip-address $ip1.."
