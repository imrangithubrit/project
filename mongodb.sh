#copy mongodb.repo file/root/project
echo -e "\e[33m Copy the Mongo.repo file\e[0m"
cp /root/project/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33m Installing the mongodb file\e[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log

#Modify the confg file
echo -e "\e[33m starting the nginx server\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log