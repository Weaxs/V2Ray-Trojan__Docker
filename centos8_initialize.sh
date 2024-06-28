#!/bin/bash

# 定义紫色输出函数
function purple() {
  printf "\033[0;35m%s\033[0m\n" "$1"
}

# 安装 Docker
function installDocker() {
  purple "安装 Docker..."
  sudo yum install -y yum-utils
  if [ $? -ne 0 ]; then
    purple "安装 yum-utils 失败"
    exit 1
  fi

  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  if [ $? -ne 0 ]; then
    purple "添加 Docker 仓库失败"
    exit 1
  fi

  sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  if [ $? -ne 0 ]; then
    purple "安装 Docker 失败"
    exit 1
  fi

  purple "Docker 安装完成"
}

# 安装 Git
function installGit() {
  purple "安装 Git..."
  sudo yum install -y git
  if [ $? -ne 0 ]; then
    purple "安装 Git 失败"
    exit 1
  fi
  purple "Git 安装完成"
}

# 安装 Certbot
function installCertbot() {
  purple "安装 Certbot..."

  sudo dnf install -y epel-release
  if [ $? -ne 0 ]; then
    purple "安装 EPEL 仓库失败"
    exit 1
  fi

  sudo dnf upgrade -y
  if [ $? -ne 0 ]; then
    purple "升级系统失败"
    exit 1
  fi

  sudo yum install -y snapd
  if [ $? -ne 0 ]; then
    purple "安装 snapd 失败"
    exit 1
  fi

  sudo systemctl enable --now snapd.socket
  if [ $? -ne 0 ]; then
    purple "启用 snapd 失败"
    exit 1
  fi

  sudo ln -s /var/lib/snapd/snap /snap
  if [ $? -ne 0 ]; then
    purple "创建 snap 链接失败"
    exit 1
  fi

  sudo snap install --classic certbot
  if [ $? -ne 0 ]; then
    purple "安装 Certbot 失败"
    exit 1
  fi

  sudo ln -s /snap/bin/certbot /usr/bin/certbot
  if [ $? -ne 0 ]; then
    purple "创建 Certbot 链接失败"
    exit 1
  fi

  purple "Certbot 安装完成"
}

# 主安装流程
installDocker
installGit
installCertbot

purple "所有安装操作完成"
