#!/bin/bash
if [ ! -d "/usr/local/bin" ]; then
	echo \'/usr/local/bin\' not found, creating one.
	sudo mkdir -p -m 775 /usr/local/bin
	sudo chown $USER:admin /usr/local/bin
fi
sudo cp ALCPlugFix /usr/local/bin/
sudo chmod 755 /usr/local/bin/ALCPlugFix
sudo chown $USER:admin /usr/local/bin/ALCPlugFix
sudo cp hda-verb /usr/local/bin/
sudo chmod 755 /usr/local/bin/hda-verb
sudo chown $USER:admin /usr/local/bin/hda-verb
sudo cp good.win.ALCPlugFix.plist /Library/LaunchDaemons/
sudo chmod 644 /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo chown root:wheel /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo launchctl load /Library/LaunchDaemons/good.win.ALCPlugFix.plist

echo "Done!"
exit 0
