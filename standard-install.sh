#!/bin/bash
# [ $(pwd) == $(echo $HOME) ] && echo "ok" || echo "$(pwd) is not $HOME"
if [ $(pwd) != $(echo $HOME) ] ; then
	cp .bash_aliases ~/
fi

source .bash_aliases

# comment this out. Use raspi-config to enable pigpiod instead
# sudo chmod 0755 pigpiod.service && sudo chown root pigpiod.service && sudo cp pigpiod.service /etc/systemd/system/

sudo apt update && sudo apt upgrade

sudo apt-get -y install tmux mc neovim nmap arp-scan

sudo systemctl enable pigpiod
sudo systemctl start pigpiod

# check if ssh key exists, else create
# add steps for docker installation

git config --global init.defaultBranch main
