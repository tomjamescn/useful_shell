#!/bin/sh

user_home_dir=/home/$1
if [ ! -d "$user_home_dir" ]; then
  echo "$user_home_dir does NOT exist!"
  exit
fi

#注意这一步，apache需要
chmod +x $user_home_dir

cd $user_home_dir
svn co svn://192.168.1.22/www/eeecx/web ./www
sed -ie "s/.*DB_HOST.*/\t'DB_HOST'   => '127.0.0.1', \/\/服务器地址 /" ./www/Application/Web/Conf/config.php
sed -ie "s/.*DB_USER.*/\t'DB_USER'   => 'root', \/\/用户名 /" ./www/Application/Web/Conf/config.php
sed -ie "s/.*DB_PWD.*/\t'DB_PWD'   => '', \/\/密码 /" ./www/Application/Web/Conf/config.php
sed -ie "s/.*DB_HOST.*/\t'DB_HOST'   => '127.0.0.1', \/\/服务器地址 /" ./www/Application/Wechat/Conf/config.php
sed -ie "s/.*DB_USER.*/\t'DB_USER'   => 'root', \/\/用户名 /" ./www/Application/Wechat/Conf/config.php
sed -ie "s/.*DB_PWD.*/\t'DB_PWD'   => '', \/\/密码 /" ./www/Application/Wechat/Conf/config.php

#.htaccess文件，虽然svn中有，到时
cat <<EOM >/home/$1/www/.htaccess
<IfModule mod_rewrite.c>
  Options +FollowSymlinks
  RewriteEngine On

  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteRule ^(.*)$ index.php/\$1 [QSA,PT,L]
</IfModule>
EOM

chmod -R 777 /home/$1/www/.htaccess

chmod -R 777 /home/$1/www

#apache vhost

mkdir -p /home/$1/apache/$1.dev.com/
chmod -R 777 /home/$1/apache

cat <<EOM >/etc/httpd/sites-enabled/$1.dev.com.conf
<VirtualHost *:80>
    ServerName $1.dev.com
    DocumentRoot /home/$1/www
    ErrorLog /home/$1/apache/$1.dev.com/error.log
    CustomLog /home/$1/apache/$1.dev.com/requests.log combined

    <Directory "/home/$1/www">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOM


echo "OK"
echo ""
