#!/bin/bash

#to be executed by root user
USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo -e "\e[1;31mYou must be a root user\e[0m"
  exit 1
fi
