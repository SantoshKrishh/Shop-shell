#echo -e "\e[33m>>>>><<<<<\e[0m"

echo -e "\e[33m>>>>> Copying service file <<<<<\e[0m"
cp /home/centos/Shop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[33m>>>>> Enabling latest NOdejs <<<<<\e[0m"
dnf module disable nodejs -y &>>/tmp/user-roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Installing NodeJS <<<<<\e[0m"
dnf install nodejs -y &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Create Application user <<<<<\e[0m"
useradd roboshop &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Creating App directory <<<<<\e[0m"
rm -rf /app &>>/tmp/user-roboshop.log
mkdir /app &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Downloading Application Code <<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Changing Directory and Extracting Code content <<<<<\e[0m"
cd /app &>>/tmp/user-roboshop.log
unzip -o /tmp/user.zip  &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Downloading Dependencies <<<<<\e[0m"
cd /app &>>/tmp/user-roboshop.log
npm install &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Replacing <MONGODB-SERVER-IPADDRESS> with IP address  <<<<<\e[0m"
sed -i -e "s/<MONGODB-SERVER-IPADDRESS>/mongodb.roboshopsk.shop/" /etc/systemd/system/user.service &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Loading the service <<<<<\e[0m"
systemctl daemon-reload &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Starting the service <<<<<\e[0m"
systemctl enable user &>>/tmp/user-roboshop.log
systemctl start user &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> copying mongodb repo file <<<<<\e[0m"
cp /home/centos/Shop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/mongodb-roboshop.log

echo -e "\e[33m>>>>> Installing Mongodb-client <<<<<\e[0m"
dnf install mongodb-org-shell -y &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Loading master data  <<<<<\e[0m"
mongo --host mongodb.roboshopsk.shop </app/schema/user.js &>>/tmp/user-roboshop.log

echo -e "\e[33m>>>>> Restarting the service <<<<<\e[0m"
systemctl restart user &>>/tmp/user-roboshop.log


