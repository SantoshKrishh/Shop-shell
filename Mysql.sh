echo -e "\e[33m>>>>> Disabling Mysql Default version <<<<<\e[0m"
dnf module disable mysql -y &>>/tmp/mysql-roboshop.log

echo -e "\e[33m>>>>> Copying repo file <<<<<\e[0m"
cp /home/centos/Shop-shell/mysql.repo /etc/systemd/system/mysql.repo &>>/tmp/mysql-roboshop.log

echo -e "\e[33m>>>>> Install Mysql Community version<<<<<\e[0m"
dnf install mysql-community-server -y &>>/tmp/mysql-roboshop.log

echo -e "\e[33m>>>>> Start Mysql service<<<<<\e[0m"
systemctl enable mysqld &>>/tmp/mysql-roboshop.log
systemctl restart mysqld &>>/tmp/mysql-roboshop.log

echo -e "\e[33m>>>>> Setup Mysql Password<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/mysql-roboshop.log


