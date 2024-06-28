#!/bin/bash

# 定义紫色输出函数
function purple() {
  printf "\033[0;35m%s\033[0m\n" "$1"
}

# 更新包列表并安装依赖包
purple "更新包列表并安装依赖包..."
sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release git snapd
if [ $? -ne 0 ]; then
  purple "更新包列表或安装依赖包失败"
  exit 1
fi

# 安装 Docker
purple "安装 Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
if [ $? -ne 0 ]; then
  purple "安装 Docker 失败"
  exit 1
fi

# 安装 Snap 和 Certbot
purple "安装 Snap 和 Certbot..."
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
if [ $? -ne 0 ]; then
  purple "安装 Certbot 失败"
  exit 1
fi

purple "所有安装操作完成"