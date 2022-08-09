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
echo "Done, All certificate already updates"
echo
