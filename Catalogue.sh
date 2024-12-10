#echo -e "/e[33m >>>>><<<<<  ${nocolor} "

#variables
component=catalogue
color="\e[33m"
nocolor=" ${nocolor} "

echo -e "${color}  >>>>> Copying service file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/$component.service /etc/systemd/system/$component.service

echo -e "${color}  >>>>> Enabling latest NOdejs <<<<< ${nocolor}"
dnf module disable nodejs -y &>>/tmp/$component-roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Installing NodeJS <<<<< ${nocolor}"
dnf install nodejs -y &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Create Application user <<<<< ${nocolor}"
useradd roboshop &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Creating App directory <<<<< ${nocolor}"
rm -rf /app &>>/tmp/$component-roboshop.log
mkdir /app &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Downloading Application Code <<<<< ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Changing Directory and Extracting Code content <<<<< ${nocolor}"
cd /app &>>/tmp/$component-roboshop.log
unzip -o /tmp/$component.zip  &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Downloading Dependencies <<<<< ${nocolor}"
cd /app &>>/tmp/$component-roboshop.log
npm install &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Replacing <MONGODB-SERVER-IPADDRESS> with IP address  <<<<< ${nocolor}"
sed -i -e "s/<MONGODB-SERVER-IPADDRESS>/mongodb.roboshopsk.shop/" /etc/systemd/system/$component.service &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Loading the service <<<<< ${nocolor}"
systemctl daemon-reload &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Starting the service <<<<< ${nocolor}"
systemctl enable $component &>>/tmp/$component-roboshop.log
systemctl start $component &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> copying mongodb repo file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/mongodb-roboshop.log

echo -e "${color}  >>>>> Installing Mongodb-client <<<<< ${nocolor}"
dnf install mongodb-org-shell -y &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Loading master data  <<<<< ${nocolor}"
mongo --host mongodb.roboshopsk.shop </app/schema/$component.js &>>/tmp/$component-roboshop.log

echo -e "${color}  >>>>> Restarting the service <<<<< ${nocolor}"
systemctl restart $component &>>/tmp/$component-roboshop.log


