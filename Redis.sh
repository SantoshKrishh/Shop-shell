source common.sh


echo -e "${color} >>>>> Installing Redis Repo <<<<<${nocolor}"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$log_file

echo -e "${color} >>>>> Enabling Redis Repo <<<<<${nocolor}"
dnf module enable redis:remi-6.2 -y &>>$log_file

echo -e "${color} >>>>> Installing Redis <<<<<${nocolor}"
dnf install redis -y &>>$log_file

echo -e "${color} >>>>> Updating Redis listen address <<<<<${nocolor}"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf &>>$log_file

echo -e "${color} >>>>> Starting Redis service <<<<<${nocolor}"
systemctl enable redis &>>$log_file
systemctl start redis &>>$log_file

