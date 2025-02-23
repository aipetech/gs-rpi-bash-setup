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

echo "Installing tmux, mc, neovim, nmap, arp-scan"
sudo apt-get -y install tmux mc neovim nmap arp-scan
sudo apt autoremove -y

echo "Installing pigpio"
sudo systemctl enable pigpiod
sudo systemctl start pigpiod

# check if ssh key exists, else create
# add steps for docker installation

echo "Setting default GIT repo name to main"
git config --global init.defaultBranch main
