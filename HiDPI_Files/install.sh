#!/bin/bash

export mpoint=/System/Library/Displays/Contents/Resources/Overrides/
sudo mount -o nobrowse -t apfs /dev/disk"$1"s"$2" $mpoint
sudo mkdir $mpoint/System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4
sudo mv $mpoint/System/Library/Displays/Contents/Resources/Overrides/Icons.plist $mpoint/System/Library/Displays/Contents/Resources/Overrides/IconsBackup.plist
sudo cp Icons.plist $mpoint/System/Library/Displays/Contents/Resources/Overrides/
cd DisplayVendorID-30e4
sudo cp DisplayProductID-5d0 $mpoint/System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp DisplayProductID-5d0.icns $mpoint/System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp DisplayProductID-540 $mpoint/System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp DisplayProductID-540.icns $mpoint/System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo bless --folder $mpoint/ /System/Library/CoreServices --bootefi --create-snapshot

echo "Done!"
exit 0
