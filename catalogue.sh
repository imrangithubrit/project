source common.sh
component=catalogue


nodejs

echo -e "${color} copy mongo db repo file ${nocolor}" 
cp /root/project/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>> /tmp/roboshop.log

echo -e "${color} Install mongodb ${nocolor}" 
yum install mongodb-org-shell -y  &>> /tmp/roboshop.log
mongo --host mongodb-dev.devopsb72.store </app/schema/$component.js   &>> /tmp/roboshop.log