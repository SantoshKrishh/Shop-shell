source common.sh
component=payment

echo -e "${color} >>>>> Copying service file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/payment.service /etc/systemd/system/payment.service

echo -e "${color} >>>>> Installing Python 3.6 <<<<< ${nocolor}"
dnf install python36 gcc python3-devel -y &>>$log_file

echo -e "${color} >>>>> Adding Application user <<<<< ${nocolor}"
useradd roboshop &>>$log_file

echo -e "${color} >>>>> Creating App Directory <<<<< ${nocolor}"
mkdir /app &>>$log_file

echo -e "${color} >>>>> Downloading application code <<<<< ${nocolor}"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>$log_file
cd /app &>>$log_file

echo -e "${color} >>>>> Extracting Application code <<<<< ${nocolor}"
unzip /tmp/payment.zip &>>$log_file

echo -e "${color} >>>>> Downloading the dependencies. <<<<< ${nocolor}"
pip3.6 install -r requirements.txt &>>$log_file

echo -e "${color} >>>>> Enabling and starting service <<<<< ${nocolor}"
systemctl daemon-reload &>>$log_file
systemctl enable payment &>>$log_file
systemctl restart payment &>>$log_file