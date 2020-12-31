certbot certonly --standalone -d example.com
export from_path="/etc/letsencrypt/live/example.com"
export to_path="/home/centos/docker_compose/nginx/certs"

cp $from_path/fullchain.pem $to_path/fullchain.pem
cp $from_path/privkey.pem $to_path/privkey.pem
cp $from_path/cert.pem $to_path/cert.pem
