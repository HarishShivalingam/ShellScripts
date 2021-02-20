#!/bin/bash
#!/bin/bash

COMPONENT=cart

source component/common.sh

print "Nodejs Installation" "yum install nodejs make gcc-c++ -y"
yum install nodejs make gcc-c++ -y
stat $?

print "Add roboshop user" "useradd roboshop"
id roboshop || useradd roboshop
stat $?

print "Switching to roboshop user & Importing cart services & EXIT" '"curl -s -L -o /tmp/cart.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/f62a488c-687f-4caf-9e5e-e751cf9b1603/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true""'
curl -s -L -o /tmp/cart.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/f62a488c-687f-4caf-9e5e-e751cf9b1603/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"

print "cart creation"  "/home/roboshop/cart/systemd.service && mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service"
rm -rf /home/roboshop/cart cart  && mkdir -p /home/roboshop/cart && cd /home/roboshop/cart && unzip /tmp/cart.zip
stat $?

print "Install NodeJS dependencies" "npm install && npm install  --unsafe-perm && chown roboshop:roboshop /home/roboshop -R"
npm install  --unsafe-perm && chown roboshop:roboshop /home/roboshop -R
stat $?

print "updating the IP address of MONGODB Server in systemd.service file" "sed -i -e 's/MONGO_DNSNAME/mongodb.devops2021.tk/' /home/roboshop/cart/systemd.service && mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service"
sed -i -e 's/MONGO_DNSNAME/mongodb.devops2021.tk/' /home/roboshop/cart/systemd.service && mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
stat $?

print "Start cart Service" "systemctl daemon-reload && systemctl start cart && systemctl enable cart"
systemctl daemon-reload && systemctl start cart && systemctl enable cart
stat $?