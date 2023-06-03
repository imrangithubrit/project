source common.sh
echo -e "$color Configuring Nodejs repo $nocolor" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> /tmp/roboshop.log

echo -e "$color Installing Nodejs $nocolor" 
yum install nodejs -y   &>> /tmp/roboshop.log

echo -e "$color Added Application user $nocolor" 
useradd roboshop   &>> /tmp/roboshop.log

echo -e "$color create app directory $nocolor"
rm -rf /app   &>> /tmp/roboshop.log
mkdir /app   &>> /tmp/roboshop.log

echo -e "$color download application content $nocolor" 
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip   &>> /tmp/roboshop.log

echo -e "$color Extract Application content $nocolor" 
cd /app    &>> /tmp/roboshop.log
unzip /tmp/cart.zip   &>> /tmp/roboshop.log


cd /app  &>> /tmp/roboshop.log
echo -e "$color install nodejs dependencies $nocolor"
npm install   &>> /tmp/roboshop.log

echo -e "$color copying in the cart service $nocolor"
cp /root/project/cart.service /etc/systemd/system/cart.service  &>> /tmp/roboshop.log

echo -e "$color setup systemd services $nocolor" 
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable cart  &>> /tmp/roboshop.log
systemctl restart cart &>> /tmp/roboshop.log