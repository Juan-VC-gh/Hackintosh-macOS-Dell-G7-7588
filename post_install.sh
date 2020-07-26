#!/bin/bash

#set -x

clear

echo "This Script Requires Administrator Privileges!"
echo -ne "\n"

sudo mount -uw /

C_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $C_DIR #navigate to path where install.sh was invoked

echo "Enable HiDPI"
cd HiDPI_Files/ && ./install.sh && cd ../
echo -ne "\n"


echo "Audio Jack Fixes"
cd ALCPlugFix/ && ./install.sh && cd ../
echo -ne "\n"

defaultColor="\033[0m"
red="\033[0;31m"

echo -e "$red Successfully installed, reboot now to take effect! $defaultColor"
echo -e "$red Appreciate the work? Consider donating -> https://www.paypal.me/juanvasquezcastro"
afplay /System/Library/Sounds/Glass.aiff

exit 0
