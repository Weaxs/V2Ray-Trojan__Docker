#!/bin/bash
# shellcheck disable=SC2046
curr_dir=$(dirname $(readlink -f "$0"))
echo "$curr_dir"

certbot certonly --standalone -d example.com -d trojan.example.com -d vmess.example.com -d shadowsocks.example.com
from_path="/etc/letsencrypt/live/example.com"

cp -r "$from_path" "$curr_dir"/v2fly-v4/nginx/certs
cp -r "$from_path" "$curr_dir"/v2fly-v5/nginx/certs