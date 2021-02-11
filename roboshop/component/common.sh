#!/bin/bash

#to be executed by root user
if [ "$USER_ID" -ne 0 ]; then
  echo -e "\e[31mYou must be a root user\e[0m"
fi
