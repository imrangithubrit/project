color="\e[35m"
nocolor="\e[0m"

app_present() {
 echo -e "${color} Added Application user ${nocolor}" 
 useradd roboshop   &>>/tmp/roboshop.log
 
 echo $?
 echo -e "${color} create app directory ${nocolor}"
 rm -rf /app   &>>/tmp/roboshop.log
 mkdir /app    &>>/tmp/roboshop.log
 echo $?
 echo -e "${color} download application content ${nocolor}" 
 curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip   &>>/tmp/roboshop.log
 echo $? 

 echo -e "${color} Extract Application content ${nocolor}"  
 cd /app   &>>/tmp/roboshop.log
 unzip /tmp/$component.zip   &>>/tmp/roboshop.log

 echo $?
  

}

systemd_setup()  {
 echo -e "${color} setup systemd services ${nocolor}" 
 cp /root/project/$component.service  /etc/systemd/system/$component.service &>>/tmp/roboshop.log
 echo -e "${color} starts $component services ${nocolor}" 
 systemctl daemon-reload  &&>>/tmp/roboshop.log
 systemctl enable $component &>>/tmp/roboshop.log
 systemctl restart $component  &>>/tmp/roboshop.log
 echo $?
}




nodejs()  {
 echo -e "${color} Configuring Nodejs repo ${nocolor}" 

 curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>> /tmp/roboshop.log

 echo -e "${color} Installing Node js ${nocolor}" 
 yum install nodejs -y      &>> /tmp/roboshop.log
 
 app_present
 
 echo -e "${color} install nodejs dependencies ${nocolor}"
 npm install  &>> /tmp/roboshop.log
 # Need to copy the catalogu.service file
 
} 
 


 mongo_schemasetup() {

 echo -e "${color} copy mongo db repo file ${nocolor}" 
 cp /root/project/mongodb.repo /etc/yum.repos.d/mongodb.repo  &>> /tmp/roboshop.log

 echo -e "${color} Install mongodb ${nocolor}" 
 yum install mongodb-org-shell -y  &>> /tmp/roboshop.log
 mongo --host mongodb-dev.devopsb72.store </app/schema/$component.js   &>> /tmp/roboshop.log
 
 }
mysql_schema_setup(){
 yum install mysql -y 

 mysql -h mysql-dev.devopsb72.store -uroot -pRoboShop@1 < /app/schema/${component}.sql 


}
maven() {
 yum install maven -y


 app_present

 mvn clean package 
 mv target/{component}-1.0.jar {component}.jar 

 systemd_setup

}

python() {

 echo -e "${color} Installing python ${nocolor}"
 yum install python36 gcc python3-devel -y
 echo $?
 app_presetup

 echo -e "${color} Install application dependencies${nocolor}" 
 cd /app 
 pip3.6 install -r requirements.txt

 systemd_setup

}
