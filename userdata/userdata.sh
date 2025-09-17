#!/bin/bash
apt update -y
apt install -y apache2
echo "<h1>Welcome to ${env_name} Website 🚀</h1>" > /var/www/html/index.html
systemctl enable apache2
systemctl start apache2

%{ if use_rds == false }
DEBIAN_FRONTEND=noninteractive apt install -y mysql-server
mysql --execute="ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${db_root_password}'; FLUSH PRIVILEGES;"
mysql --user=root --password=${db_root_password} --execute="CREATE DATABASE ${db_name};"
mysql --user=root --password=${db_root_password} --execute="CREATE USER '${db_user}'@'%' IDENTIFIED BY '${db_password}';"
mysql --user=root --password=${db_root_password} --execute="GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'%'; FLUSH PRIVILEGES;"
systemctl enable mysql
systemctl start mysql
%{ endif }
