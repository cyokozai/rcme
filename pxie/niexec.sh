#!/bin/sh
set -e

read "password: " password
echo "$password" | sudo -S apt -y update && sudo -S apt -y upgrade && sudo -S apt dist-upgrade

cd /home
curl 
[ -e *.deb ] && echo "$password" | sudo apt -S install ./
echo "$password" | sudo -S apt -y install 
rm -f *.deb

read -n1 -p "Press any key to reboot now..."
echo "$password" | sudo -S reboot