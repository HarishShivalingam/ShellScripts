#!/bin/bash

#to be executed by root user
USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo -e "\e[1;31mYou must be a root user\e[0m"
  exit
fi

print() {
  echo "\e]1m$(date +c%) \e[35m$(hostname) \e\1;36m${COMPONENT} :: $1"
  }

#print() {
  #echo -e "[\e[1;34mINFO\e[0m]---------------------< $1 >--------------------
  #echo -e "[\e[1;34mINFO\e[0m]\e[1m $2 \e[0m"
#}
