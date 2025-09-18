#!/bin/bash
apt update -y
apt install -y apache2

%{ if !var.use_rds ~}
# Install MySQL locally (Dev)
apt install -y mysql-server
mysql -e "CREATE DATABASE ${var.db_name};"
mysql -e "CREATE USER '${var.db_user}'@'%' IDENTIFIED BY '${var.db_password}';"
mysql -e "GRANT ALL PRIVILEGES ON ${var.db_name}.* TO '${var.db_user}'@'%';"
%{ endif ~}

echo "<h1>Welcome to ${var.env_name} Website 🚀</h1>" > /var/www/html/index.html
systemctl enable apache2
systemctl start apache2
