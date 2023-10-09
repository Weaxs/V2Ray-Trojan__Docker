# docker
# https://docs.docker.com/engine/install/centos/
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# git
sudo yum install git

# certbot
# https://snapcraft.io/docs/installing-snap-on-centos
sudo dnf install epel-release
sudo dnf upgrade
sudo yum install snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

# https://certbot.eff.org/instructions
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
