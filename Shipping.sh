echo -e "\e[33m>>>>> Installing Maven <<<<<\e[0m"
dnf install maven -y &>>/tmp/shipping-roboshop.log

echo -e "\e[33m>>>>> Copying service file <<<<<\e[0m"
cp /home/centos/Shop-shell/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[33m>>>>> Adding Application user <<<<<\e[0m"
useradd roboshop &>>/tmp/shipping-roboshop.log

echo -e "\e[33m>>>>> creating App directory <<<<<\e[0m"
rm -rf /app &>>/tmp/shipping-roboshop.log
mkdir /app &>>/tmp/shipping-roboshop.log

echo -e "\e[33m>>>>> Downloading Application content <<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/shipping-roboshop.log
cd /app &>>/tmp/shipping-roboshop.log
unzip /tmp/shipping.zip &>>/tmp/shipping-roboshop.log

echo -e "\e[33m>>>>> Downloading Dependencies <<<<<\e[0m"
mvn clean package &>>/tmp/shipping-roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/shipping-roboshop.log

echo -e "\e[33m>>>>> Install MySQL Client <<<<<\e[0m"
dnf install mysql -y &>>/tmp/shipping-roboshop.log

echo -e "\e[33m>>>>> Load Schema <<<<<\e[0m"
mysql -h mysql.roboshopsk.shop -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/shipping-roboshop.log

echo -e "\e[33m>>>>> Enable and start services <<<<<\e[0m"
systemctl daemon-reload &>>/tmp/shipping-roboshop.log
systemctl enable shipping &>>/tmp/shipping-roboshop.log
systemctl restart shipping &>>/tmp/shipping-roboshop.log
