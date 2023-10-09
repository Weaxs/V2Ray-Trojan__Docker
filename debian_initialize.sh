# docker (https://docs.docker.com/engine/install/debian/)
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# snap (https://snapcraft.io/docs/installing-snap-on-debian)
sudo apt update
sudo apt install snapd
# certbot (https://certbot.eff.org/instructions)
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# git
sudo apt-get install git 


