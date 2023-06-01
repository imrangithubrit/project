
yum install maven -y

useradd roboshop

mkdir /app 

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
cd /app 
unzip /tmp/shipping.zip

cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 

# copy shipping
cp /root/project/shipping.service /etc/systemd/system/shipping.service

systemctl daemon-reload

systemctl enable user 
systemctl restart user

#copy the mongob file
cp /root/project/mongodb.repo /etc/yum.repos.d/mongodb.repo

yum install mongodb-org-shell -y

mongo --host mongodb-dev.devopsb72.store </app/schema/user.js