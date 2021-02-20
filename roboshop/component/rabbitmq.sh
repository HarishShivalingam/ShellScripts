#!/bin/bash
COMPONENT=common
source component/common.sh

print "Installing Erlang" "yum install https://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_22.2.1-1~centos~7_amd64.rpm -y"
yum install https://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_22.2.1-1~centos~7_amd64.rpm -y
stat $?

print "Setup YUM repositories for RabbitMQ" "curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash

print "Install RabbitMQ" "yum install rabbitmq-server -y"
stat $?

print "Start RabbitMQ"  "systemctl enable rabbitmq-server && systemctl start rabbitmq-server"
systemctl enable rabbitmq-server && systemctl start rabbitmq-server
stat $?

print "Create application user" "rabbitmqctl add_user roboshop roboshop123 && rabbitmqctl set_user_tags roboshop administrator && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*""
rabbitmqctl add_user roboshop roboshop123 && rabbitmqctl set_user_tags roboshop administrator && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
