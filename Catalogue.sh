#echo -e "\e[33m>>>>><<<<<\e[0m"

echo -e "\e[33m>>>>> Copying service file <<<<<\e[0m"
cp /home/centos/Shop-shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[33m>>>>> Enabling latest NOdejs <<<<<\e[0m"
dnf module disable nodejs -y &>>/tmp/catalogue-roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Installing NodeJS <<<<<\e[0m"
dnf install nodejs -y &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Create Application user <<<<<\e[0m"
useradd roboshop &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Creating App directory <<<<<\e[0m"
mkdir /app &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Downloading Application Code <<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Changing Directory and Extracting Code content <<<<<\e[0m"
cd /app &>>/tmp/catalogue-roboshop.log
unzip /tmp/catalogue.zip &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Downloading Dependencies <<<<<\e[0m"
cd /app &>>/tmp/catalogue-roboshop.log
npm install &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Replacing <MONGODB-SERVER-IPADDRESS> with IP address  <<<<<\e[0m"
sed -i -e "s/<MONGODB-SERVER-IPADDRESS>/172.31.44.189/" /etc/systemd/system/catalogue.service &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Loading the service <<<<<\e[0m"
systemctl daemon-reload &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Starting the service <<<<<\e[0m"
systemctl enable catalogue &>>/tmp/catalogue-roboshop.log
systemctl start catalogue &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> copying mongodb repo file <<<<<\e[0m"
cp /home/centos/Shop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/mongodb-roboshop.log

echo -e "\e[33m>>>>> Installing Mongodb-client <<<<<\e[0m"
dnf install mongodb-org-shell -y &>>/tmp/catalogue-roboshop.log

echo -e "\e[33m>>>>> Loading master data  <<<<<\e[0m"
mongo --host 172.31.44.189 </app/schema/catalogue.js &>>/tmp/catalogue-roboshop.log


