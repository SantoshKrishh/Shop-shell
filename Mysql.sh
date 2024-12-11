source common.sh

echo -e "${color} >>>>> Disabling Mysql Default version <<<<< ${nocolor}"
dnf module disable mysql -y &>>$log_file

echo -e "${color} >>>>> Copying repo file <<<<< ${nocolor}"
cp /home/centos/Shop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file

echo -e "${color} >>>>> Install Mysql Community version<<<<< ${nocolor}"
dnf install mysql-community-server -y &>>$log_file

echo -e "${color} >>>>> Start Mysql service<<<<< ${nocolor}"
systemctl enable mysqld &>>$log_file
systemctl restart mysqld &>>$log_file

echo -e "${color} >>>>> Setup Mysql Password<<<<< ${nocolor}"
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file


