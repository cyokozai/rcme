#!/bin/sh
set -e

if [ $# -le 1 ]; then
    echo "Error: Specify the name of the driver to be installed as an argument."
    exit 1
fi

sudo -S apt -y update && sudo -S apt -y upgrade && sudo -S apt dist-upgrade
sudo apt -y install unzip curl

cd /home/$USER/

curl -O https://download.ni.com/support/softlib/MasterRepository/LinuxDrivers2024Q1/NILinux2024Q1DeviceDrivers.zip
unzip NILinux2024Q1DeviceDrivers.zip
sudo apt install ~/NILinux2024Q1DeviceDrivers/ni-ubuntu2204-drivers-2024Q1.deb

for driver in "${@:1}"; do
    sudo apt -y install "$driver"
done

read -n1 -p "Press any key to reboot now..."
sudo -S reboot
