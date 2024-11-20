echo -e "\e[33m>>>>> Copying service file <<<<<\e[0m"
cp /home/centos/Shop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/dispatch-roboshop.log

echo -e "\e[33m>>>>> Installing GoLang <<<<<\e[0m"
dnf install golang -y >>/tmp/dispatch-roboshop.log

echo -e "\e[33m>>>>> Adding application User <<<<<\e[0m"
useradd roboshop >>/tmp/dispatch-roboshop.log

echo -e "\e[33m>>>>> setting app directory <<<<<\e[0m"
mkdir /app >>/tmp/dispatch-roboshop.log

echo -e "\e[33m>>>>> Downloading application code <<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip >>/tmp/dispatch-roboshop.log

echo -e "\e[33m>>>>> Extracting Application content <<<<<\e[0m"
cd /app >>/tmp/dispatch-roboshop.log
unzip /tmp/dispatch.zip >>/tmp/dispatch-roboshop.log

echo -e "\e[33m>>>>> Downloading dependencies & Building software <<<<<\e[0m"
go mod init dispatch >>/tmp/dispatch-roboshop.log
go get >>/tmp/dispatch-roboshop.log
go build >>/tmp/dispatch-roboshop.log

echo -e "\e[33m>>>>> Enabling and starting service  <<<<<\e[0m"
systemctl daemon-reload >>/tmp/dispatch-roboshop.log
systemctl enable dispatch >>/tmp/dispatch-roboshop.log
systemctl restart dispatch >>/tmp/dispatch-roboshop.log