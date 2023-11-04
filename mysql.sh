echo -e "\e[31m disabled mysql \e[0m"
dnf module disable mysql -y $/tmp/expense.log

echo -e "\e[31m copied mysql.repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo $/tmp/expense.log

echo -e "\e[31m installed mysql \e[0m"
dnf install mysql-community-server -y $/tmp/expense.log

echo -e "\e[31m stared services \e[0m"
systemctl enable mysqld $/tmp/expense.log
systemctl restart mysqld $/tmp/expense.log

echo -e "\e[31m setup the password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 $/tmp/expense.log