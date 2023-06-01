#copy mongodb.repo file/root/project

cp /root/project/2 Mongodb.repo /etc/yum.repos.d/2 Mongodb.repo


yum install mongodb-org -y 

#Modify the confg file

systemctl enable mongod 
systemctl restart mongod