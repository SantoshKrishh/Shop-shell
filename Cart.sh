#echo -e "\e[33m>>>>><<<<<\e[0m"

echo -e "\e[33m>>>>> Copying service file <<<<<\e[0m"
cp /home/centos/Shop-shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[33m>>>>> Enabling latest NOdejs <<<<<\e[0m"
dnf module disable nodejs -y &>>/tmp/cart-roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/cart-roboshop.log

echo -e "\e[33m>>>>> Installing NodeJS <<<<<\e[0m"
dnf install nodejs -y &>>/tmp/cart-roboshop.log

echo -e "\e[33m>>>>> Create Application user <<<<<\e[0m"
useradd roboshop &>>/tmp/cart-roboshop.log

echo -e "\e[33m>>>>> Creating App directory <<<<<\e[0m"
rm -rf /app &>>/tmp/cart-roboshop.log
mkdir /app &>>/tmp/cart-roboshop.log

echo -e "\e[33m>>>>> Downloading Application Code <<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/cart-roboshop.log

echo -e "\e[33m>>>>> Changing Directory and Extracting Code content <<<<<\e[0m"
cd /app &>>/tmp/cart-roboshop.log
unzip -o /tmp/cart.zip  &>>/tmp/cart-roboshop.log

echo -e "\e[33m>>>>> Downloading Dependencies <<<<<\e[0m"
cd /app &>>/tmp/cart-roboshop.log
npm install &>>/tmp/cart-roboshop.log

echo -e "\e[33m>>>>> Restarting the service <<<<<\e[0m"
systemctl daemon-reload &>>/tmp/cart-roboshop.log
systemctl enable cart &>>/tmp/cart-roboshop.log
systemctl restart cart &>>/tmp/cart-roboshop.log






