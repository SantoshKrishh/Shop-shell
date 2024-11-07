echo -e "\e[33m>>>>> Installing Redis Repo <<<<<\e[0m"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/redis-roboshop.log

echo -e "\e[33m>>>>> Enabling Redis Repo <<<<<\e[0m"
dnf module enable redis:remi-6.2 -y &>>/tmp/redis-roboshop.log

echo -e "\e[33m>>>>> Installing Redis <<<<<\e[0m"
dnf install redis -y &>>/tmp/redis-roboshop.log

echo -e "\e[33m>>>>> Updating Redis listen address <<<<<\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf &>>/tmp/redis-roboshop.log

echo -e "\e[33m>>>>> Starting Redis service <<<<<\e[0m"
systemctl enable redis &>>/tmp/redis-roboshop.log
systemctl start redis &>>/tmp/redis-roboshop.log

