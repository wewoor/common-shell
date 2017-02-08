#!/bin/bash

# 快速登录服务器
# author: Ziv
# github: https://github.com/wewoor/common-shell

# server config
deploy_host="127.0.0.1"
deploy_server="root@$deploy_host"
deploy_dir="/home/production/"

echo "Input your server password."

ssh-add ~/.ssh/somekey
ssh -t $deploy_server "cd $deploy_dir; bash;";
