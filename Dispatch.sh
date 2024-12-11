source common.sh
component=dispatch

echo -e "${color} >>>>> Copying service file <<<<< ${nocolor} "
cp /home/centos/Shop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>$log_file

echo -e "${color} >>>>> Installing GoLang <<<<< ${nocolor} "
dnf install golang -y &>>$log_file

echo -e "${color} >>>>> Adding application User <<<<< ${nocolor} "
useradd roboshop &>>$log_file

echo -e "${color} >>>>> setting app directory <<<<< ${nocolor} "
mkdir /app &>>$log_file

echo -e "${color} >>>>> Downloading application code <<<<< ${nocolor} "
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>$log_file

echo -e "${color} >>>>> Extracting Application content <<<<< ${nocolor} "
cd /app &>>$log_file
unzip /tmp/dispatch.zip &>>$log_file

echo -e "${color} >>>>> Downloading dependencies & Building software <<<<< ${nocolor} "
go mod init dispatch &>>$log_file
go get &>>$log_file
go build &>>$log_file

echo -e "${color} >>>>> Enabling and starting service  <<<<< ${nocolor} "
systemctl daemon-reload &>>$log_file
systemctl enable dispatch &>>$log_file
systemctl restart dispatch &>>$log_file