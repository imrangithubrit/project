echo -e "\e[33m Disable mysql default version\e[0m" 
yum module disable mysql -y 

# copy mysql repo file
echo -e "\e[33m copy the mysql repo file\e[0m"
cp /root/project/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[33m install mysql community\e[0m"
yum install mysql-community-server -y

echo -e "\e[33m starting the service\e[0m"
systemctl enable mysqld
systemctl restart mysqld 

echo -e "\e[33m Disable mysql default version\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
