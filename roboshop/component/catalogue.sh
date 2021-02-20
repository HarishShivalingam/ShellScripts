#!/bin/bash

COMPONENT=catalogue

source component/common.sh

print "Nodejs Installation" "yum install nodejs make gcc-c++ -y"
yum install nodejs make gcc-c++ -y
stat $?

print "Add roboshop user" "useradd roboshop"
id roboshop || useradd roboshop
stat $?

print "Switching to roboshop user & Importing catalogue services & EXIT" '"curl -s -L -o /tmp/catalogue.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/d62914b9-61e7-4147-ab33-091f23c7efd4/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"'
curl -s -L -o /tmp/catalogue.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/d62914b9-61e7-4147-ab33-091f23c7efd4/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"

print "Catalogue creation"  "/home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service"
rm -rf /home/roboshop/catalogue catalogue  && mkdir -p /home/roboshop/catalogue && cd /home/roboshop/catalogue && unzip /tmp/catalogue.zip
stat $?

print "Install NodeJS dependencies" "npm install && npm install  --unsafe-perm && exit"
npm install  --unsafe-perm && exit
stat $?

print " updating the IP address of MONGODB Server in systemd.service file" '"sed -i -e "s/MONGO_DNSNAME/mongodb.devops2021.tk/" /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service"'
sed -i -e "s/MONGO_DNSNAME/mongodb.devops2021.tk/" /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
stat $?

print "Start Catalogue Service" "systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue"
systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue
#systemctl daemon-reload
#systemctl start catalogue
#systemctl enable catalogue
#stat $?

