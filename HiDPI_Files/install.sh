#!/bin/bash

#set -x

clear

echo "This Script Requires Administrator Privileges!"

sudo mount -uw /

C_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function progressIndicator(){
echo -ne '[..........................] (0%)\r'
echo -ne '[#.........................] (5%)\r'
echo -ne '[##........................] (10%)\r'
echo -ne '[###.......................] (15%)\r'
echo -ne '[####......................] (20%)\r'
echo -ne '[#####.....................] (25%)\r'
echo -ne '[#####.....................] (25%)\r'
echo -ne '[######....................] (30%)\r'
echo -ne '[#######...................] (35%)\r'
echo -ne '[########..................] (40%)\r'
echo -ne '[#########.................] (45%)\r'
echo -ne '[##########................] (50%)\r'
echo -ne '[###########...............] (55%)\r'
echo -ne '[[############..............] (60%)\r'
echo -ne '[#############.............] (65%)\r'
echo -ne '[###############...........] (70%)\r'
echo -ne '[#################.........] (75%)\r'
echo -ne '[####################......] (80%)\r'
echo -ne '[#######################...] (85%)\r'
echo -ne '[##########################] (100%)\r'
echo -ne '\n'
}

cd /System/Library/Displays/Contents/Resources/Overrides/
sudo mv Icons.plist IconsBackup.plist

sudo mkdir DisplayVendorID-30e4

cd $C_DIR #navigate to path where install.sh was invoked

echo "Copying files to enable native HiDPI resolutions"

sudo cp Icons.plist /System/Library/Displays/Contents/Resources/Overrides/
echo "Install Icons.plist:"
progressIndicator
echo -ne "\n"

cd DisplayVendorID-30e4

sudo cp DisplayProductID-5d0 /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
echo "Install DisplayProductID-5d0:"
progressIndicator
echo -ne "\n"

sudo cp DisplayProductID-5d0.icns /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
echo "Install DisplayProductID-5d0.icns:"
progressIndicator
echo -ne "\n"

sudo cp DisplayProductID-540 /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
echo "Install DisplayProductID-540:"
progressIndicator
echo -ne "\n"

sudo cp DisplayProductID-540.icns /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
echo "Install DisplayProductID-540.icns:"
progressIndicator
echo -ne "\n"

defaultColor="\033[0m"
red="\033[0;31m"

echo -e "$red Successfully installed, reboot now to take effect! $defaultColor"
echo -e "$red Appreciate the work? Consider donating -> https://www.paypal.me/juanvasquezcastro"
afplay /System/Library/Sounds/Glass.aiff

exit 0
