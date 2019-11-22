**Hackintosh-macOS-Catalina-on-Dell-G7-7588**

**README will be updated later when I get more time.**

In the meantime I am uploading **day one** working files to boot Catalina installer and the fully functional macOS.

A few things to note:

* Wi-Fi and Bluetooth work flawlessly even 5GHz networks, AirDrop and Continuity. I bought a DW1820A (BCM94350ZAE) from eBay part number: 08PKF4 and subsystem id: 106B:0023 if you buy a different card other that the DW1820A you will need to modify the config.plist to inject properties via PCI Root address. It requires pin-masking to work, otherwise it will cause issues like macOS rebooting when you click Shut Down, etc. Below you can fin a picture of which pins to mask (red pins).
![Imgur](https://i.imgur.com/kof6tzz.png)
* The procedure to install is almost identical as with Mojave.
* When installing, delete VoodooPS2KeyboardController inside USB/EFI/Clover/kexts/Other and place VoodooPS2 found in the Installation driver folder.
* Found out that using CPUFriend to allow the CPU to go down to 0.8Ghz leaves same result in battery as letting macOS manage the CPU itself so I am not using it anymore (will probably upload some fresh new profiles if you still miss one).
* Updated every possible driver.
* Tested SMBIOS MacBookPro15,1 as they are sold with better processors than MBP15,2 (which only comes with integrated graphics) and determined that MBP15,2 is the way to go as it only has iGPU you can use a TB3 to HDMI adapter to mirror to an external display which is not possible with MBP15,1 which comes with dual gpu (not even by setting pmset gpuswitch to 0).
* The EFI folder works for both USB installation and booting the operating system. Using Clover with AptioMemoryFix UEFI driver instead of any OsxAptioFix.
* Created proper files to enable native HiDPI on this laptop. Is it gonna make your laptop logo look bigger when booting which is totally fine for me to enable these tasty resolutions if you are good with that. (I personally love using the resolution which makes UI look like 1440 x 810 but it is actually rendering double quantity of pixels 2880 x 1620)

You can install everything by using my Mojave guide for now; but of the tricky HiDPI files because of macOS Catalina being installed in a separate volume now and automatically enabling SIP.

First you need to make sure you create a macOS USB by using the installer from the AppStore as we need to enter macOS recovery (otherwise it will not allow you to diable SIP while logged; according to terminal, only on recovery) and some software tend to remove it.

Let's start by shutting down the computer and booting again, but this time choose Recovery from Clover's main menu.
Wait for it to boot. Then go to the Utilities tab located at the top and launch terminal. 

Now enter the following commands:

	csrutil disable
	
You are safe to reboot now, when logged go to terminal and type (because even with SIP disabled macOS system files are in a read-only volume):
	
	sudo mount -uw /
	killall Finder
	
Fine, we now need to place the files at:

	/System/Library/Displays/Contents/Resources/Overrides/

After navigating to the folder above look for the Icons.plist file and rename it to IconsBackup.plist

Finally, copy the included folder and Icon.plist file included in the repo and reboot! You can now go to Settings -> Displays and choose scale resolution to pick the one that suits you.

* Note that every time you reboot the operating system will change the system volume to read-only again so make sure to run the proper commands if you want to modify again it later. 

* Also remember it is healthy to repair permissions and rebuild cache every time that you Hackintosh is updated.

	```
	sudo chmod -Rf 755 /L*/E*
	sudo chown -Rf 0:0 /L*/E*
	sudo kextcache -i /

Enjoy you new ~~Mac~~ Hackintosh!

## Credits

* Apple for macOS
* The Clover team
* VoodooI2C team
* Rehabman
* vit9696
