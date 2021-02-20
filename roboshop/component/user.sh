#!/bin/bash
#!/bin/bash

COMPONENT=user

source component/common.sh

print "Nodejs Installation" "yum install nodejs make gcc-c++ -y"
yum install nodejs make gcc-c++ -y
stat $?

print "Add roboshop user" "useradd roboshop"
id roboshop || useradd roboshop
stat $?

print "Switching to roboshop user & Importing user services & EXIT" '"curl -s -L -o /tmp/user.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/8cd1d535-7b52-4823-9003-7b52db898c08/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"'
curl -s -L -o /tmp/user.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/8cd1d535-7b52-4823-9003-7b52db898c08/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
$ cd /home/roboshop

print "user creation"  "/home/roboshop/user/systemd.service && mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service"
rm -rf /home/roboshop/user user  && mkdir -p /home/roboshop/user && cd /home/roboshop/user && unzip /tmp/user.zip
stat $?

print "Install NodeJS dependencies" "npm install && npm install  --unsafe-perm && chown roboshop:roboshop /home/roboshop -R"
npm install  --unsafe-perm && chown roboshop:roboshop /home/roboshop -R
stat $?

print "updating the IP address of MONGODB Server in systemd.service file" "sed -i -e 's/MONGO_DNSNAME/mongodb.devops2021.tk/' /home/roboshop/user/systemd.service && mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service"
sed -i -e 's/MONGO_DNSNAME/mongodb.devops2021.tk/' /home/roboshop/user/systemd.service && mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
stat $?

print "Start user Service" "systemctl daemon-reload && systemctl start user && systemctl enable user"
systemctl daemon-reload && systemctl start user && systemctl enable user
stat $?