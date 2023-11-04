log_file=/tmp/expense.log
color="\e[33m"

echo -e "${color} Installing Nginx \e[0m"
dnf install nginx -y &>>$log_file

echo -e "${color} copy file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file

echo -e "${color} Removed a file \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file

echo -e "${color} Download a zip file \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file

echo -e "${color} unzip the file \e[0m"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file

echo -e "${color} start the nginx \e[0m"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
