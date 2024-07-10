#!/bin/bash
# shellcheck disable=SC2046
curr_dir=$(dirname $(readlink -f "$0"))
echo "$curr_dir"

certbot certonly --standalone -d trojan.example.com -d vmess.example.com -d shadowsocks.example.com -d vless.weaxsey.org
from_path="/etc/letsencrypt/live/trojan.example.com"
cp "$from_path"/fullchain.pem "$from_path"/fullchain.crt

cp -PR "$from_path" "$curr_dir"/v2fly4.vless-vmess-trojan/nginx/certs
cp -PR "$from_path" "$curr_dir"/v2fly4.vless-vmess-trojan-shadowsocks/nginx/certs
cp -PR "$from_path" "$curr_dir"/v2fly5.vmess-trojan-shadowsocks/nginx/certs