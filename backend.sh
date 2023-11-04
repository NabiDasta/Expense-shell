
echo -e "\e[31m enabling nodejs \e[0m"
dnf module disable nodejs -y $/tmp/expense.log
dnf module enable nodejs:18 -y $/tmp/expense.log

echo -e "\e[31m install nodejs \e[0m"
dnf install nodejs -y $/tmp/expense.log

echo -e "\e[31m copying the backend services \e[0m"
cp backend.service /etc/systemd/system/backend.service $/tmp/expense.log

echo -e "\e[31m useradd \e[0m"
useradd expense $/tmp/expense.log

echo -e "\e[31m created app directory \e[0m"
mkdir /app $/tmp/expense.log

echo -e "\e[31m downloaded the zip file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip $/tmp/expense.log

echo -e "\e[31m unzip the file \e[0m"
cd /app $/tmp/expense.log
unzip /tmp/backend.zip $/tmp/expense.log

echo -e "\e[31m installed dependenties  \e[0m"
npm install $/tmp/expense.log

echo -e "\e[31m install mysql \e[0m"
dnf install mysql -y $/tmp/expense.log

echo -e "\e[31m setup the passwords \e[0m"
mysql -h mysql-dev.nadevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql $/tmp/expense.log

echo -e "\e[31m service started \e[0m"
systemctl daemon-reload $/tmp/expense.log
systemctl enable backend $/tmp/expense.log
systemctl restart backend $/tmp/expense.log
