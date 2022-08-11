sudo apt-get remove nginx nginx-common -y 
sudo apt-get purge nginx nginx-common -y
sudo apt-get autoremove -y
rm -rf /etc/nginx
sudo apt-get remove nginx-full nginx-common -y

sudo apt remove --purge nginx* -y
sudo apt autoremove
#sudo apt update
#sudo apt install nginx
