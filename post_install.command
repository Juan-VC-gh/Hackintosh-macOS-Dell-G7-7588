#!/bin/bash
#set -x

clear

echo "Dell G7 7588 post-install script by Juan-VC"
echo "This Script Requires Administrator Privileges!"
if [[ $EUID -ne 0 ]];
then
    exec sudo /bin/zsh "$0" "$@"
fi
echo -ne "\n"

cd "$(dirname "$0")" # path where post_install.command was invoked
cd HiDPI_Files/ && ./install.sh
cd "$(dirname "$0")"
cd ALCPlugFix-Swift && ./install.sh

# disable unnecesary/not supported features and save power
sudo pmset -a hibernatemode 0
sudo rm -rf /var/vm/sleepimage
sudo mkdir -p /var/vm/sleepimage
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
sudo pmset -a powernap 0
sudo pmset -a proximitywake 0

defaultColor="\033[0m"
red="\033[0;31m"

echo -e ""$red"\nSuccessfully installed, reboot now to take effect! $defaultColor"
echo -e ""$red"Appreciate the work? Consider donating -> https://www.paypal.me/juanvasquezcastro"
afplay /System/Library/Sounds/Glass.aiff

echo "\nPress any key to finish"
while [ true ]
do
	read -t 3 -n 1
if [ $? = 0 ]
then
	exit
fi
done
echo
exit 1