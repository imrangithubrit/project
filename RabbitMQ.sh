
echo -e "\e[33m Configure erlang repo\e[0m"

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[33m rebiitmq repo\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[33m Installing rabitmq server\e[0m"
yum install rabbitmq-server -y 

echo -e "\e[33m starting the Rabbitmq service\e[0m"
systemctl enable rabbitmq-server 
systemctl restart rabbitmq-server 

echo -e "\e[33m rabit mq Application user\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"