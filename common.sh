color="\e[35m"
nocolor="\e[0m"


nodejs()  {
  echo -e "${color} Configuring Nodejs repo ${nocolor}" 

 curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>> /tmp/roboshop.log

 echo -e "${color} Installing Node js ${nocolor}" 
 yum install nodejs -y      &>> /tmp/roboshop.log

 echo -e "${color} Added Application user ${nocolor}" 
 useradd roboshop   &>> /tmp/roboshop.log

 echo -e "${color} create app directory ${nocolor}"
 rm -rf /app   &>> /tmp/roboshop.log
 mkdir /app    &>> /tmp/roboshop.log

 echo -e "${color} download application content ${nocolor}" 
 curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip   &>> /tmp/roboshop.log 

 echo -e "${color} Extract Application content ${nocolor}" 
 cd /app   &>> /tmp/roboshop.log
 unzip /tmp/$component.zip   &>> /tmp/roboshop.log

 cd /app  &>> /tmp/roboshop.log
 echo -e "${color} install nodejs dependencies ${nocolor}"
 npm install  &>> /tmp/roboshop.log
 # Need to copy the catalogu.service file
 echo -e "${color} setup systemd services ${nocolor}" 
 cp /root/project/$component.service  /etc/systemd/system/$component.service &>> /tmp/roboshop.log

 echo -e "${color} starts $component services ${nocolor}" 
 systemctl daemon-reload  &>> /tmp/roboshop.log
 systemctl enable $component &>> /tmp/roboshop.log
 systemctl restart $component  &>> /tmp/roboshop.log
}


 mongo_schemasetup() {

 echo -e "${color} copy mongo db repo file ${nocolor}" 
 cp /root/project/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>> /tmp/roboshop.log

 echo -e "${color} Install mongodb ${nocolor}" 
 yum install mongodb-org-shell -y  &>> /tmp/roboshop.log
 mongo --host mongodb-dev.devopsb72.store </app/schema/$component.js   &>> /tmp/roboshop.log
 
 }