echo -e "\e[33m Installing the ngix\e[0m"
yum install nginx -y 

echo -e "\e[33m Removing the old app content\e[0m"
rm -rf /usr/share/nginx/html/* 

echo -e "\e[33m Downloading the frontend\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
 
echo -e "\e[33m Extract the frontend content\e[0m"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip

# create new roboshop.conf file

echo -e "\e[33m starting the nginx server\e[0m"
systemctl enable nginx
systemctl restart nginx 