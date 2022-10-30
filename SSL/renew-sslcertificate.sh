#!/bin/bash 
clear
echo
echo "Renewing SSL Certificate ....."
echo
sudo systemctl status certbot.timer
echo
sudo certbot renew --dry-run
echo
echo
systemctl restart nginx
echo
systemctl status nginx
echo
echo "Done, All certificate already updates"
echo
