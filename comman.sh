log_file="/tmp/expense.log"
color="\e[33m"

if [ -z "$1" ]; then
  echo password input missing
  exit
fi

MYSQL_PASSWORD=$1

function_check() {
 if [ $? -eq 0 ]; then
   echo -e "\e[32m SUCCESS \e[0m"
 else
   echo -e "\e[31m FAILURE \e[0m"
 fi
 }