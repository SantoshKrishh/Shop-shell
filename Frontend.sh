dnf install nginx -y

systemctl enable nginx


rm -rf /usr/share/nginx/html/*

cd /usr/share/nginx/html
unzip /tmp/frontend.zip

systemctl restart nginx