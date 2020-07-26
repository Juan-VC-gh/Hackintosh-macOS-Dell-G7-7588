#!/bin/bash
sudo mkdir /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4
sudo mv /System/Library/Displays/Contents/Resources/Overrides/Icons.plist /System/Library/Displays/Contents/Resources/Overrides/IconsBackup.plist
sudo cp Icons.plist /System/Library/Displays/Contents/Resources/Overrides/
cd DisplayVendorID-30e4
sudo cp DisplayProductID-5d0 /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp DisplayProductID-5d0.icns /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp DisplayProductID-540 /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp DisplayProductID-540.icns /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/

echo "Done!"
exit 0
