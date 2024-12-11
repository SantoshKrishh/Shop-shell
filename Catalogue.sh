#echo -e "/e[33m >>>>><<<<<  ${nocolor} "

#variables
source common.sh
component=catalogue

echo -e "${color}  >>>>> Copying service file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/$component.service /etc/systemd/system/$component.service

echo -e "${color}  >>>>> Enabling latest NOdejs <<<<< ${nocolor}"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file

echo -e "${color}  >>>>> Installing NodeJS <<<<< ${nocolor}"
dnf install nodejs -y &>>$log_file

echo -e "${color}  >>>>> Create Application user <<<<< ${nocolor}"
useradd roboshop &>>$log_file

echo -e "${color}  >>>>> Creating App directory <<<<< ${nocolor}"
rm -rf /app &>>$log_file
mkdir /app &>>$log_file

echo -e "${color}  >>>>> Downloading Application Code <<<<< ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file

echo -e "${color}  >>>>> Changing Directory and Extracting Code content <<<<< ${nocolor}"
cd /app &>>$log_file
unzip -o /tmp/$component.zip  &>>$log_file

echo -e "${color}  >>>>> Downloading Dependencies <<<<< ${nocolor}"
cd /app &>>$log_file
npm install &>>$log_file

echo -e "${color}  >>>>> Replacing <MONGODB-SERVER-IPADDRESS> with IP address  <<<<< ${nocolor}"
sed -i -e "s/<MONGODB-SERVER-IPADDRESS>/mongodb.roboshopsk.shop/" /etc/systemd/system/$component.service &>>$log_file

echo -e "${color}  >>>>> Loading the service <<<<< ${nocolor}"
systemctl daemon-reload &>>$log_file

echo -e "${color}  >>>>> Starting the service <<<<< ${nocolor}"
systemctl enable $component &>>$log_file
systemctl start $component &>>$log_file

echo -e "${color}  >>>>> copying mongodb repo file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/mongodb-roboshop.log

echo -e "${color}  >>>>> Installing Mongodb-client <<<<< ${nocolor}"
dnf install mongodb-org-shell -y &>>$log_file

echo -e "${color}  >>>>> Loading master data  <<<<< ${nocolor}"
mongo --host mongodb.roboshopsk.shop </app/schema/$component.js &>>$log_file

echo -e "${color}  >>>>> Restarting the service <<<<< ${nocolor}"
systemctl restart $component &>>$log_file


