#!/bin/bash
clear
echo
echo "Installing SSL Letsencrypt"
echo

sudo apt-get install python3-certbot-nginx
sudo add-apt-repository ppa:certbot/certbot -y
sudo apt-get install software-properties-common -y
echo
clear
echo
nginx -t
echo
systemctl status nginx
echo
jawaban="Y"
jawabanlain="y"
read -p "checking NGINX selesai, apakah anda ingin melanjutkan instalasi? (y/n)" pilih;
if [ $pilih = $jawaban ] || [ $pilih = $jawabanlain ];
then
clear
echo
echo "Masukkan nama domain yang akan di tambahkan sertifikat SSL :"
read nama_domain;
echo
#sudo certbot --nginx -d $nama_domain -d $nama_domain
echo
sudo tee /etc/nginx/sites-enabled/$nama_domain<<EOF
server {
    server_name $nama_domain;

        location / {
                include /etc/nginx/proxy_params;
                proxy_pass          http://localhost:3000;
                proxy_read_timeout  60s;
        # Fix the "It appears that your reverse proxy set up is broken" error.
        # Make sure the domain name is correct
                proxy_redirect      http://localhost:3000 http://$nama_domain;
        }


    listen 443 ssl; # managed by Certbot

    ssl_certificate /etc/letsencrypt/live/$nama_domain/fullchain.pem;
# managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/$nama_domain/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {
    if ($host = $nama_domain) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name $nama_domain;
    return 404; # managed by Certbot


}
EOF
nano  /etc/nginx/sites-enabled/$nama_domain
echo
echo "Cek apakah SSL sudah terbentuk di folder LIVE:"
echo
cd /etc/letsencrypt/live/
ls

else
echo
echo "Installasi dibatalkan, terimakasih sudah menggunakan aplikasi kami"
echo
exit 1
fi
echo
