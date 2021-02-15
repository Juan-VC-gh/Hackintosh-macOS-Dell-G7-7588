#!/bin/bash

echo "Enabling HiDPI"

sudo mkdir -p /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp Icons.plist /Library/Displays/Contents/Resources/Overrides/
cd DisplayVendorID-30e4
sudo cp DisplayProductID-5d0 /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp DisplayProductID-5d0.icns /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp DisplayProductID-540 /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/
sudo cp DisplayProductID-540.icns /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/

echo "Done!"
echo
exit 0
