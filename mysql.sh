log_file="/tmp/expense.log"
color="\e[32m"

echo -e "${color} disabled mysql \e[0m"
dnf module disable mysql -y &>>$log_file
echo $?

echo -e "color copied mysql.repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
echo $?

echo -e "\e[31m installed mysql \e[0m"
dnf install mysql-community-server -y &>>$log_file
echo $?

echo -e "\e[31m stared services \e[0m"
systemctl enable mysqld &>>$log_file
systemctl restart mysqld &>>$log_file
echo $?

echo -e "\e[31m setup the password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file