echo -e "\e[33m Configuring Nodejs repo\e[0m" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> /tmp/roboshop.log

echo -e "\e[33m Installing Nodejs \e[0m" 
yum install nodejs -y   &>> /tmp/roboshop.log

echo -e "\e[33m Added Application user\e[0m" 
useradd roboshop   &>> /tmp/roboshop.log

echo -e "\e[33m create app directory\e[0m"
rm -rf /app   &>> /tmp/roboshop.log
mkdir /app   &>> /tmp/roboshop.log

echo -e "\e[33m download application content\e[0m" 
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip   &>> /tmp/roboshop.log

echo -e "\e[33m Extract Application content\e[0m" 
cd /app    &>> /tmp/roboshop.log
unzip /tmp/cart.zip   &>> /tmp/roboshop.log


cd /app  &>> /tmp/roboshop.log
echo -e "\e[33m install nodejs dependencies\e[0m"
npm install   &>> /tmp/roboshop.log

echo -e "\e[33m copying in the cart service\e[0m"
cp /root/project/cart.service /etc/systemd/system/cart.service

echo -e "\e[33m setup systemd services\e[0m" 
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable cart  &>> /tmp/roboshop.log
systemctl restart cart &>> /tmp/roboshop.log