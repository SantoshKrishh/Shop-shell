#echo -e "\e[33m>>>>><<<<<\e[0m"

echo -e "\e[33m>>>>> copying mongodb repo file <<<<<\e[0m"
cp /home/centos/Shop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/mongodb-roboshop.log

echo -e "\e[33m>>>>> Install MongoDB <<<<<\e[0m"
dnf install mongodb-org -y &>>/tmp/mongodb-roboshop.log

echo -e "\e[33m>>>>> update mongodb listen address <<<<<\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>/tmp/mongodb-roboshop.log

echo -e "\e[33m>>>>> Start & Enable MongoDB Service <<<<<\e[0m"
systemctl enable mongod &>>/tmp/mongodb-roboshop.log
systemctl restart mongod &>>/tmp/mongodb-roboshop.log