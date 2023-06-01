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
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 

echo -e "\e[33m Extract Application content\e[0m" 
cd /app 
unzip /tmp/user.zip

cd /app 
echo -e "\e[33m install nodejs dependencies\e[0m"
npm install 

# copy user.service file
echo -e "\e[33m setup systemd services\e[0m" 
cp /root/project/user.service  /etc/systemd/system/user.service &>> /tmp/roboshop.log

systemctl enable user 
systemctl restart user

#copy mongodb.repo file
echo -e "\e[33m copy mongo db repo file\e[0m" 
cp /root/project/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>> /tmp/roboshop.log

echo -e "\e[33m Install mongodb\e[0m" 
yum install mongodb-org-shell -y


mongo --host mongodb-dev.devopsb72.store </app/schema/user.js
