#echo -e "${color} >>>>><<<<< ${nocolor}"

source common.sh
component=user

echo -e "${color} >>>>> Copying service file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/user.service /etc/systemd/system/user.service

echo -e "${color} >>>>> Enabling latest NOdejs <<<<< ${nocolor}"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file

echo -e "${color} >>>>> Installing NodeJS <<<<< ${nocolor}"
dnf install nodejs -y &>>$log_file

echo -e "${color} >>>>> Create Application user <<<<< ${nocolor}"
useradd roboshop &>>$log_file

echo -e "${color} >>>>> Creating App directory <<<<< ${nocolor}"
rm -rf /app &>>$log_file
mkdir /app &>>$log_file

echo -e "${color} >>>>> Downloading Application Code <<<<< ${nocolor}"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>$log_file

echo -e "${color} >>>>> Changing Directory and Extracting Code content <<<<< ${nocolor}"
cd /app &>>$log_file
unzip -o /tmp/user.zip  &>>$log_file

echo -e "${color} >>>>> Downloading Dependencies <<<<< ${nocolor}"
cd /app &>>$log_file
npm install &>>$log_file

echo -e "${color} >>>>> Replacing <MONGODB-SERVER-IPADDRESS> with IP address  <<<<< ${nocolor}"
sed -i -e "s/<MONGODB-SERVER-IPADDRESS>/mongodb.roboshopsk.shop/" /etc/systemd/system/user.service &>>$log_file

echo -e "${color} >>>>> Loading the service <<<<< ${nocolor}"
systemctl daemon-reload &>>$log_file

echo -e "${color} >>>>> Starting the service <<<<< ${nocolor}"
systemctl enable user &>>$log_file
systemctl start user &>>$log_file

echo -e "${color} >>>>> copying mongodb repo file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/mongodb-roboshop.log

echo -e "${color} >>>>> Installing Mongodb-client <<<<< ${nocolor}"
dnf install mongodb-org-shell -y &>>$log_file

echo -e "${color} >>>>> Loading master data  <<<<< ${nocolor}"
mongo --host mongodb.roboshopsk.shop </app/schema/user.js &>>$log_file

echo -e "${color} >>>>> Restarting the service <<<<< ${nocolor}"
systemctl restart user &>>$log_file


