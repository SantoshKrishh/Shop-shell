source common.sh
component=shipping

echo -e "${color} >>>>> Installing Maven <<<<< ${nocolor}m"
dnf install maven -y &>>$log_file

echo -e "${color} >>>>> Copying service file <<<<< ${nocolor}m"
cp /home/centos/Shop-shell/shipping.service /etc/systemd/system/shipping.service

echo -e "${color} >>>>> Adding Application user <<<<< ${nocolor}m"
useradd roboshop &>>$log_file

echo -e "${color} >>>>> creating App directory <<<<< ${nocolor}m"
rm -rf /app &>>$log_file
mkdir /app &>>$log_file

echo -e "${color} >>>>> Downloading Application content <<<<< ${nocolor}m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>$log_file
cd /app &>>$log_file
unzip /tmp/shipping.zip &>>$log_file

echo -e "${color} >>>>> Downloading Dependencies <<<<< ${nocolor}m"
mvn clean package &>>$log_file
mv target/shipping-1.0.jar shipping.jar &>>$log_file

echo -e "${color} >>>>> Install MySQL Client <<<<< ${nocolor}m"
dnf install mysql -y &>>$log_file

echo -e "${color} >>>>> Load Schema <<<<< ${nocolor}m"
mysql -h mysql.roboshopsk.shop -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>$log_file

echo -e "${color} >>>>> Enable and start services <<<<< ${nocolor}m"
systemctl daemon-reload &>>$log_file
systemctl enable shipping &>>$log_file
systemctl restart shipping &>>$log_file
