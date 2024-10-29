echo -e "\e[33m>>>>>>Install Nginx<<<<<<<<\e[0m"
dnf install nginx -y &>>/tmp/frontend-roboshop.log

echo -e "\e[33m>>>>>>>removing Web server content<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/frontend-roboshop.log

echo -e "\e[33m>>>>>>Downloading Roboshop webserver content<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/frontend-roboshop.log

echo -e "\e[33m>>>>>>Unzipping webserver content <<<<<<<\e[0m"
cd /usr/share/nginx/html &>>/tmp/frontend-roboshop.log
unzip /tmp/frontend.zip &>>/tmp/frontend-roboshop.log

cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[33m>>>>>>>>>>>>>>>>>Restarting Nginx Service<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl enable nginx &>>/tmp/frontend-roboshop.log
systemctl restart nginx &>>/tmp/frontend-roboshop.log

#echo -e "\e[33m\e[0m"