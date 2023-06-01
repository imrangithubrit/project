echo -e "\e[33m Installing redis repo file\e[0m" 
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

echo -e "\e[33m enable the redis 6 version\e[0m"
yum module enable redis:remi-6.2 -y   &>>/tmp/roboshop.log

echo -e "\e[33m Installing the redis\e[0m"
yum install redis -y   &>>/tmp/roboshop.log


#need to config redis.conf file
echo -e "\e[33m conf ip addess 127.0.0.1 to 0.0.0.0\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf  &>>/tmp/roboshop.log

echo -e "\e[33m starting the service\e[0m"
systemctl enable redis  &>>/tmp/roboshop.log
systemctl restart redis  &>>/tmp/roboshop.log