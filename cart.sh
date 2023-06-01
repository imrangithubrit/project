echo -e "\e[33m Configuring Nodejs repo\e[0m" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[33m Installing Nodejs \e[0m" 
yum install nodejs -y

echo -e "\e[33m Added Application user\e[0m" 
useradd roboshop

echo -e "\e[33m create app directory\e[0m"
rm -rf /app   &>> /tmp/roboshop.log
mkdir /app 

echo -e "\e[33m download application content\e[0m" 
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 

echo -e "\e[33m Extract Application content\e[0m" 
cd /app 
unzip /tmp/cart.zip


cd /app 
echo -e "\e[33m install nodejs dependencies\e[0m"
npm install 

echo -e "\e[33m setup systemd services\e[0m" 
systemctl daemon-reload

systemctl enable cart 
systemctl restart cart