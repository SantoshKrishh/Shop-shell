source common.sh

root_password=$1
if [ -z "$root_password" ]; then
  echo "root_password is missing"
  exit 1
fi

echo -e " ${color}  Disable MySQL Default Version  ${nocolor} "
yum module disable mysql -y &>>/tmp/roboshop.log
stat_check $?

echo -e " ${color}  Copy MySQL repo file  ${nocolor} "
cp /home/centos/Shop-shell/mysql.repo /etc/yum.repos.d/mysql.repo  &>>/tmp/roboshop.log
stat_check $?

echo -e " ${color}  Install MySQL Community Server  ${nocolor} "
yum install mysql-community-server -y &>>/tmp/roboshop.log
stat_check $?

echo -e " ${color}  Start MySQL Service  ${nocolor} "
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log
stat_check $?

echo -e " ${color}  Setup MySQL Password  ${nocolor} "
mysql_secure_installation --set-root-pass $root_password &>>/tmp/roboshop.log
stat_check $?