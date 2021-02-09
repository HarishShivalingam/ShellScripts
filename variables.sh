echo="welcome to shell"
#VAR=$(COMMAND)
date=$(date +%F)
echo "Today's date is $date"

#Arithmetic Substitution
# Two braces are used $(()) one for arithmetic and other for command
add=$((2+5+123))
echo add = $add
#Variables should not start with number
#Variables by default no data type

#read and convert to variable give it seprately after colon

read -p 'Enter your name:' name
read -p 'Enter your age:' age

echo -e "\n your name is $name \n your age is $age"
#Special variables

echo 0 = $0
echo 1 = $1
echo 2 = $2
echo "* = $*"
echo "@ = $@"
echo "# = $#"

#Redirectors
# Ex: Bash/Shell Terminal for input (>_) and mysql terminal for output (<_)
# (>) or (1>) gives standard out
# (2>) gives error out put ex: >>
#if std out put and error to same file the use (&>)
#EX: ls -l sample.txt null.sh >/tmp/out 2>/tmp/err
#if no output needed for reference the use &>/dev/null

#Exit status
#o is universal success and 1 to 255 is failure