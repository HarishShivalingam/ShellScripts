#!/bin/bash
COMPONENT=mysql
source component/common

print "Setup Mysql Repo" ""echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo""

echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
stat $?

print "Removing old version & installing new version" "yum remove mariadb-libs -y && yum install mysql-community-server -y"
yum remove mariadb-libs -y && yum install mysql-community-server -y
stat $?

print "Starting Mysql" "systemctl enable mysqld && systemctl start mysqld"
systemctl enable mysqld && systemctl start mysqld
stat $?

print "Fetch Default password" "grep temp /var/log/mysqld.log"
DEFAULT_PASSWORD=$( grep'temporary password' /var/log/mysqld.log | awk '{print $NF}')
stat $?

echo "show databases;" | mysql -uroot -ppassword &>/dev/null
if [ $? -ne 0 ]; then
  print "Reset MySql password" ""
  mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" <<EOF
  ALTER USER 'root'@'localhost' IDENTIFIED by 'Default_Roboshop*999';
  uninstall plugin validate_password;
  ALTER USER 'root'@'localhost' IDENTIFIED by 'password';
EOF
  stat $?
fi

print "Download the schema" ""
curl -s -L -o /tmp/mysql.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/2235ab8a-3229-47d9-8065-b56713ed7b28/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true" && cd /tmp && unzip mysql.zip && mysql -u root -ppassword <shipping.sql