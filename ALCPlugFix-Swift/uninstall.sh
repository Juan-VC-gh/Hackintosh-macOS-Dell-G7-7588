#!/bin/zsh

#  ALCPlugFix-Swift Uninstall
#  
#  Created by akisame-reiu on 09/27/21
#  
 
# Clean up

sudo launchctl unload /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo rm /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo rm /Library/Preferences/com.black-dragon74.ALCPlugFix.config.plist
sudo rm /usr/local/bin/ALCPlugFix
