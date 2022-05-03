#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd mariadb-server
sudo systemctl start httpd
sudo systemctl enable httpd
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo systemctl start mariadb
sudo service mysqld start

# everything else was installed manually 
# sudo usermod -a -G apache ec2-user
# sudo chown -R ec2-user:apache /var/www
# sudo chmod 2775 /var/www
# find /var/www -type d -exec sudo chmod 2775 {} \;
# find /var/www -type f -exec sudo chmod 0664 {} \;


# LOG INTO THE DB 
# mysql -u root -p
# CREATE USER 'wordpress-irina'@'localhost' IDENTIFIED BY '**********';
# CREATE DATABASE `wordpress-db`;
# GRANT ALL PRIVILEGES ON `wordpress-db`.* TO "wordpress-irina"@"localhost";
# FLUSH PRIVILEGES;

# WP
# cp wordpress/wp-config-sample.php wordpress/wp-config.php
# sudo vi wordpress/wp-config.php
# define('DB_NAME', 'wordpress-db');
# define('DB_USER', 'wordpress-irina');
# define('DB_PASSWORD', '*************');

# cp -r wordpress/* /var/www/html/
# mkdir /var/www/html/blog
# cp -r wordpress/* /var/www/html/blog/
# sudo vi /etc/httpd/conf/httpd.conf
# changed AllowOverride All
# sudo yum install php-gd
# sudo chown -R apache /var/www
# sudo chgrp -R apache /var/www
# sudo chmod 2775 /var/www
# find /var/www -type d -exec sudo chmod 2775 {} \;
# find /var/www -type f -exec sudo chmod 0644 {} \;
# sudo systemctl restart httpd
# sudo systemctl enable httpd && sudo systemctl enable mariadb
# sudo systemctl start mariadb
# sudo systemctl start httpd
# access through the browser using Public IP 
