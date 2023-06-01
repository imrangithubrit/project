echo -e "\e[33m Configuring Nodejs repo\e[0m" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>> /tmp/roboshop.log

echo -e "\e[33m Installing Node js\e[0m" 
yum install nodejs -y      &>> /tmp/roboshop.log

echo -e "\e[33m Added Application user\e[0m" 
useradd roboshop   &>> /tmp/roboshop.log

echo -e "\e[33m create app directory\e[0m"
rm -rf /app   &>> /tmp/roboshop.log
mkdir /app    &>> /tmp/roboshop.log

echo -e "\e[33m download application content\e[0m" 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip   &>> /tmp/roboshop.log 

echo -e "\e[33m Extract Application content\e[0m" 
cd /app   &>> /tmp/roboshop.log
unzip /tmp/catalogue.zip   &>> /tmp/roboshop.log

cd /app  &>> /tmp/roboshop.log
echo -e "\e[33m install nodejs dependencies\e[0m"
npm install  &>> /tmp/roboshop.log
# Need to copy the catalogu.service file
echo -e "\e[33m setup systemd services\e[0m" 
cp /root/project/catalogue.service /etc/systemd/system/catalogue.service &>> /tmp/roboshop.log

echo -e "\e[33m starts catalogue services\e[0m" 
systemctl daemon-reload  &>> /tmp/roboshop.log
systemctl enable catalogue &>> /tmp/roboshop.log
systemctl restart catalogue  &>> /tmp/roboshop.log

echo -e "\e[33m copy mongo db repo file\e[0m" 
cp /root/project/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>> /tmp/roboshop.log

echo -e "\e[33m Install mongodb\e[0m" 
yum install mongodb-org-shell -y  &>> /tmp/roboshop.log
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js   &>> /tmp/roboshop.log