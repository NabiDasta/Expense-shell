echo -e "\e[31m enabling nodejs \e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[31m install nodejs \e[0m"
dnf install nodejs -y

echo -e "\e[31m copying the backend services \e[0m"
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[31m useradd \e[0m"
useradd expense

echo -e "\e[31m created app directory \e[0m"
mkdir /app

echo -e "\e[31m downloaded the zip file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip

echo -e "\e[31m unzip the file \e[0m"
cd /app
unzip /tmp/backend.zip

echo -e "\e[31m installed dependenties  \e[0m"
npm install

echo -e "\e[31m install mysql \e[0m"
dnf install mysql -y

echo -e "\e[31m setup the passwords \e[0m"
mysql -h mysql-dev.nadevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

echo -e "\e[31m service started \e[0m"
systemctl daemon-reload
systemctl enable backend
systemctl restart backend
