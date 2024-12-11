#echo -e "${color} >>>>><<<<< ${nocolor}"
source common.sh
component=cart

echo -e "${color} >>>>> Copying service file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/cart.service /etc/systemd/system/cart.service &>>$log_file

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
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>$log_file

echo -e "${color} >>>>> Changing Directory and Extracting Code content <<<<< ${nocolor}"
cd /app &>>$log_file
unzip -o /tmp/cart.zip  &>>$log_file

echo -e "${color} >>>>> Downloading Dependencies <<<<< ${nocolor}"
cd /app &>>$log_file
npm install &>>$log_file

echo -e "${color} >>>>> Restarting the service <<<<< ${nocolor}"
systemctl daemon-reload &>>$log_file
systemctl enable cart &>>$log_file
systemctl restart cart &>>$log_file






