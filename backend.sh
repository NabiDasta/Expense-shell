log_file="/tmp/expense.log"
color="\e[33m"

echo -e "${color} enabling nodejs \e[0m"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:18 -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m install nodejs \e[0m"
dnf install nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m copying the backend services \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m useradd \e[0m"
useradd expense &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m created app directory \e[0m"
mkdir /app &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m Deleted app directory \e[0m"
rm -rf /app/* &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m downloaded the zip file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m unzip the file \e[0m"
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m installed dependenties  \e[0m"
npm install &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m install mysql \e[0m"
dnf install mysql -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m setup the passwords \e[0m"
mysql -h mysql-dev.nadevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi

echo -e "\e[31m service started \e[0m"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo -e "\e[31m FAILURE \e[0m"
fi