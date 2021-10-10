#!/bin/zsh

echo "Fixing sound..."
#  ALCPlugFix-Swift Install
#  
#  Created by akisame-reiu on 09/27/21, based on install.sh created by Nick.
#  

sudo mkdir -p /usr/local/bin
sudo rm -rf /usr/local/bin/ALCPlugFix
sudo rm -rf /usr/local/bin/hda-verb
sudo rm -rf /Library/LaunchAgents/good.win.ALCPlugFix.plist

## Copy new files
sudo cp ALCPlugFix-Swift /usr/local/bin/ALCPlugFix
sudo cp com.black-dragon74.ALCPlugFix.plist /Library/LaunchAgents
sudo cp com.black-dragon74.ALCPlugFix.config.plist /Library/Preferences

sudo chmod 755 /usr/local/bin/ALCPlugFix
sudo chmod 644 /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo chmod 644 /Library/Preferences/com.black-dragon74.ALCPlugFix.config.plist

sudo chown root:wheel /usr/local/bin/ALCPlugFix
sudo chown root:wheel /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo chown root:wheel /Library/Preferences/com.black-dragon74.ALCPlugFix.config.plist

sudo launchctl load /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist

echo "Done!"
echo
exit 1