#!/bin/bash
COMPONENT=shipping
source component/common

print "Maven Installation" "yum install maven -y"

print "Add roboshop user" "useradd roboshop"
id roboshop || useradd roboshop
stat $?

print "Download shipping code" "curl -s -L -o /tmp/shipping.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/9c06b317-6353-43f6-81e2-aa4f5f258b2d/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true""
curl -s -L -o /tmp/shipping.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/9c06b317-6353-43f6-81e2-aa4f5f258b2d/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
stat $?
print "Extracting code""unzip /tmp/shipping.zip"
mkdir -p /home/roboshop/shipping && cd /home/roboshop/shipping
unzip -o /tmp/shipping.zip
stat $?

print "Maven compile code" "mvn clean package && mv target/shipping-1.0.jar shipping.jar"
mvn clean package && mv target/shipping-1.0.jar shipping.jar

print "updating systemD for shipping" "sed -i -e 's/MONGO_DNSNAME/mongodb.devops2021.tk/' /home/roboshop/shipping/systemd.service && mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service"
sed -i -e 's/CART_ENDPOINT/cart.devops2021.tk/' -e 's/DBHOST/mongodb.devops2021.tk/'  /home/roboshop/shipping/systemd.service  && mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
stat $?

print "Start shipping Service" "systemctl daemon-reload && systemctl start shipping && systemctl enable shipping"
systemctl daemon-reload && systemctl start shipping && systemctl enable shipping
stat $?
print "Copy the service file and start the service" ""
cp /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl start shipping
systemctl enable shipping