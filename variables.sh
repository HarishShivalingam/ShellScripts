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
