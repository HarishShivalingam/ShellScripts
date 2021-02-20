#!/bin/bash

COMPONENT=redis
source component/common.sh

print "Installing Redis" "yum install epel-release yum-utils -y && yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y && yum-config-manager --enable remi && yum install redis -y"
yum install epel-release yum-utils -y && yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y && yum-config-manager --enable remi  && yum install redis -y
stat $?

print "Updating Bind IP" "sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/redis.conf"
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/redis.conf
stat $?

print "Start Redis Database" "systemctl enable redis && systemctl start redis "
systemctl enable redis
systemctl start redis
stat $?