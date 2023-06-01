echo -e "\e[33m Disable mysql default version\e[0m" 
yum module disable mysql -y  &>> /tmp/roboshop.log

# copy mysql repo file
echo -e "\e[33m copy the mysql repo file\e[0m"
cp /root/project/mysql.repo /etc/yum.repos.d/mysql.repo   &>> /tmp/roboshop.log

echo -e "\e[33m install mysql community\e[0m"
yum install mysql-community-server -y   &>> /tmp/roboshop.log

echo -e "\e[33m starting the service\e[0m"
systemctl enable mysqld  &>> /tmp/roboshop.log
systemctl restart mysqld   &>> /tmp/roboshop.log

echo -e "\e[33m Disable mysql default version\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1  &>> /tmp/roboshop.log
