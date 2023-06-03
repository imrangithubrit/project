echo -e "\e[33m Installing python\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[33m add application user\e[0m"
useradd roboshop

echo -e "\e[33m create directory\e[0m"
rm -rf /app
mkdir /app 


echo -e "\e[33m download application content\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 

echo -e "\e[33m extract applcation content\e[0m"
cd /app 
unzip /tmp/payment.zip

echo -e "\e[33m Install application dependencies\e[0m"
cd /app 
pip3.6 install -r requirements.txt

#copy payment service file
echo -e "\e[33m copy paymentservice file\e[0m"
cp /root/project/payment.service /etc/systemd/system/payment.service

echo -e "\e[33m start payment servoce\e[0m"
systemctl daemon-reload
systemctl enable payment 
systemctl restart payment