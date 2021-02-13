#!/bin/bash

#to be executed by root user
USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo -e "\e[1;31mYou must be a root user\e[0m"
  exit
fi

print() {
  echo -e "\e]1m$(date +c%) \e[35m$(hostname) \e\1;36m$(COMPONENT) :: $1"

  }