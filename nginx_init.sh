#!/bin/bash

# 用于服务器Nginx初始化和Web应用环境部署，
# Nginx的安装暂时支持CentOS
# author: Ziv
# github: https://github.com/wewoor/common-shell

# auto install nginx
if [ -s "/usr/sbin/nginx" ]; then
    echo "Nginx have installed."
else
    echo "Auto install nginx."
    yum install nginx
fi

order=$1

# ============ do order ============ #
# TODO do something by order

# rewrite nginx conf
nginx_conf="/etc/nginx/conf.d/example.conf"

rm $nginx_conf

cat>$nginx_conf<<'EOF'
server {
  listen  3000;
  server_name  127.0.0.1 alias localhost;
  error_log /var/log/nginx/example.error.log;
  access_log  /var/log/nginx/example.access.log  main;
  location / {
      root   /home/production/example/build;
      index  index.html;
      autoindex on;
      try_files $uri /index.html;
  }
  # 代理设置
  location ~ ^/api {
      proxy_set_header Host test.example.com;
      proxy_pass http://test.example.com;
  }
}
EOF

echo "The site configuration of nginx have installed."

nginx -s reload;

echo "Nginx have reloaded."
