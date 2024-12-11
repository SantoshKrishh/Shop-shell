#echo -e "${color} >>>>><<<<< ${nocolor}"

source common.sh


echo -e "${color} >>>>> copying mongodb repo file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file

echo -e "${color} >>>>> Install MongoDB <<<<< ${nocolor}"
dnf install mongodb-org -y &>>$log_file

echo -e "${color} >>>>> update mongodb listen address <<<<< ${nocolor}"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$log_file

echo -e "${color} >>>>> Start & Enable MongoDB Service <<<<< ${nocolor}"
systemctl enable mongod &>>$log_file
systemctl restart mongod &>>$log_file