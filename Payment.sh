echo -e "\e[33m>>>>> Copying service file <<<<<\e[0m"
cp /home/centos/Shop-shell/payment.service /etc/systemd/system/payment.service

echo -e "\e[33m>>>>> Installing Python 3.6 <<<<<\e[0m"
dnf install python36 gcc python3-devel -y &>>/tmp/payment-roboshop.log

echo -e "\e[33m>>>>> Adding Application user <<<<<\e[0m"
useradd roboshop &>>/tmp/payment-roboshop.log

echo -e "\e[33m>>>>> Creating App Directory <<<<<\e[0m"
mkdir /app &>>/tmp/payment-roboshop.log

echo -e "\e[33m>>>>> Downloading application code <<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/payment-roboshop.log
cd /app &>>/tmp/payment-roboshop.log

echo -e "\e[33m>>>>> Extracting Application code <<<<<\e[0m"
unzip /tmp/payment.zip &>>/tmp/payment-roboshop.log

echo -e "\e[33m>>>>> Downloading the dependencies. <<<<<\e[0m"
pip3.6 install -r requirements.txt &>>/tmp/payment-roboshop.log

echo -e "\e[33m>>>>> Enabling and starting service <<<<<\e[0m"
systemctl daemon-reload &>>/tmp/payment-roboshop.log
systemctl enable payment &>>/tmp/payment-roboshop.log
systemctl restart payment &>>/tmp/payment-roboshop.log