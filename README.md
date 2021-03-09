# V2ray-DockerCompse
https://certbot.eff.org/

use docker-compose to build v2ray proxy server.

    v2fly_vless use vless protocol
    v2fly_vmess use vmess protocol

when you use it, you should follow these steps:

1. apply for ssl certs by using certbot or others, and then put the certs into floder nginx/certs 
   (you can use nginx/cert.sh to apply and move certs if you have install certbot)
2. update server_name in nginx conf (default.conf & ssl.conf), which is in floder nginx/conf.d
3. update id in v2ray/v2fly conf (config.json), which is in floder nginx/v2fly_vmess and nginx/v2fly_vless

after then, start docker-compose
    
    docker-compose up -d
