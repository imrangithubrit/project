component=catalogue
color=\e[33m

echo -e "${color} Configuring Nodejs repo\e[0m" 

curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>> /tmp/roboshop.log

echo -e "${color} Installing Node js\e[0m" 
yum install nodejs -y      &>> /tmp/roboshop.log

echo -e "${color} Added Application user\e[0m" 
useradd roboshop   &>> /tmp/roboshop.log

echo -e "${color} create app directory\e[0m"
rm -rf /app   &>> /tmp/roboshop.log
mkdir /app    &>> /tmp/roboshop.log

echo -e "${color} download application content\e[0m" 
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip   &>> /tmp/roboshop.log 

echo -e "${color} Extract Application content\e[0m" 
cd /app   &>> /tmp/roboshop.log
unzip /tmp/$component.zip   &>> /tmp/roboshop.log

cd /app  &>> /tmp/roboshop.log
echo -e "${color} install nodejs dependencies\e[0m"
npm install  &>> /tmp/roboshop.log
# Need to copy the catalogu.service file
echo -e "${color} setup systemd services\e[0m" 
cp /root/project/$component.service  /etc/systemd/system/$component.service &>> /tmp/roboshop.log

echo -e "${color} starts $component services\e[0m" 
systemctl daemon-reload  &>> /tmp/roboshop.log
systemctl enable $component &>> /tmp/roboshop.log
systemctl restart $component  &>> /tmp/roboshop.log

echo -e "${color} copy mongo db repo file\e[0m" 
cp /root/project/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>> /tmp/roboshop.log

echo -e "${color} Install mongodb\e[0m" 
yum install mongodb-org-shell -y  &>> /tmp/roboshop.log
mongo --host mongodb-dev.devopsb72.store </app/schema/$component.js   &>> /tmp/roboshop.log