#copy mongodb.repo file/root/project

cp /root/project/mongodb.repo /etc/yum.repos.d/mongodb.repo


yum install mongodb-org -y 

#Modify the confg file

systemctl enable mongod 
systemctl restart mongod