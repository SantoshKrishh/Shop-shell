echo -e "\e[33m>>>>> Configuring Erlang Repos <<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[33m>>>>> Configuring RabbitMQ Repos  <<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[33m>>>>> Installing RabbitMQ Server <<<<<\e[0m"
dnf install rabbitmq-server -y

echo -e "\e[33m>>>>> Start RabbitMQ Service <<<<<\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e "\e[33m>>>>> Add RabbitMQ Application User <<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"