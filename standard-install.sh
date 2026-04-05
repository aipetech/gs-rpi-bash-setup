#!/bin/bash
# [ $(pwd) == $(echo $HOME) ] && echo "ok" || echo "$(pwd) is not $HOME"
echo "Checking if .bash_aliases exists in $HOME"
if [ -f ~/.bash_aliases ] ; then
	echo ".bash_aliases exists in $HOME"
else
	echo ".bash_aliases does not exist in $HOME, fixing..."
	cp .bash_aliases ~/
	source ~/.bash_aliases
fi

# comment this out. Use raspi-config to enable pigpiod instead
# sudo chmod 0755 pigpiod.service && sudo chown root pigpiod.service && sudo cp pigpiod.service /etc/systemd/system/

sudo apt update && sudo apt upgrade -y

echo " ## Installing tmux, mc, neovim, nmap, arp-scan"
sudo apt-get -y install tmux mc neovim nmap arp-scan micro
sudo apt autoremove -y

echo " ## Installing pigpio"
sudo apt install -y python3-setuptools python3-full
wget https://github.com/joan2937/pigpio/archive/refs/tags/v79.tar.gz
tar zxf v79.tar.gz
cd pigpio-79
make
sudo make install
sudo ldconfig
sudo chmod 0755 pigpiod.service && sudo chown root pigpiod.service && sudo cp pigpiod.service /lib/systemd/system/pigpiod.service
sudo systemctl daemon-reload
sudo systemctl enable --now pigpiod


# check if ssh key exists, else create

echo " ## Installing Docker"
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1)

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Setting default GIT repo name to main"
git config --global init.defaultBranch main
git config --global user.name aipetech
git config --global user.email aipe.silte@gmail.com
sudo usermod -aG docker $USER
echo "Log out and in again to start using docker as non-root user"
