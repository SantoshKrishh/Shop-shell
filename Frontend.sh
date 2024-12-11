source common.sh

echo -e "${color} >>>>>>Install Nginx<<<<<<<< ${nocolor}"
dnf install nginx -y &>>$log_file

echo -e "${color} >>>>>>>removing Web server content<<<<<<< ${nocolor}"
rm -rf /usr/share/nginx/html/* &>>$log_file

echo -e "${color} >>>>>>Downloading roboshop.log webserver content<<<<<<< ${nocolor}"
curl -o /tmp/frontend.zip https://roboshop.log-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file

echo -e "${color} >>>>>>Unzipping webserver content <<<<<<< ${nocolor}"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file

echo -e "${color} >>>>>>>copying conf file<<<<<<<< ${nocolor}"
cp /home/centos/Shop-shell/roboshop.log.conf /etc/nginx/default.d/roboshop.log.conf

echo -e "${color} >>>>>>>>>>>>>>>>>Restarting Nginx Service<<<<<<<<<<<<<<<<<<< ${nocolor}"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file

#echo -e "${color}  ${nocolor}"