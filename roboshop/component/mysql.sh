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

echo "show databases;" ; mysql -uroot -ppassword &>/dev/null
if [ $? -ne 0 ]; then
print "Reset MySql password"
mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED by 'Default_Roboshop*999';
uninstall plugin validate_password;
ALTER USER 'root'@'localhost' IDENTIFIED by 'password';
EOF
stat $?
fi


