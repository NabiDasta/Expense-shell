echo -e "\e[31m disabled mysql \e[0m"
dnf module disable mysql -y

echo -e "\e[31m copied mysql.repo file \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[31m installed mysql \e[0m"
dnf install mysql-community-server -y

echo -e "\e[31m stared services \e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[31m setup the password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1