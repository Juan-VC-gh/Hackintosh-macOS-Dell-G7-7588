**Hackintosh-macOS-Catalina-on-Dell-G7-7588**

**Clover is becoming an obsolate bootloader when using a hackintosh with newer macOS releases and update. Check the master branch to setup OpenCore.  Clover branch might not get more updates.**

**README will be updated later when I get more time.**

In the meantime I am uploading **day one** working files to boot Catalina installer and the fully functional macOS.

A few things to note:

* Wi-Fi and Bluetooth work flawlessly even 5GHz networks and Continuity. I bought a card listed as a BCM94352Z from AliExpress part number: 08XRYC which carries a bluetooth vendor-id:0x413C and device-id:0x8143, that means it is a DW1550 (4352+20702 combo) but sold as a m.2 form factor 2230 rather than a half mini pcie. This Broadcom card works quite impressive under Catalina with proper patches (already included).

* There is **ONLY** one clover folder that can be used for both installation and post-installation. The need of a USB mouse when installing was a sacrifice that has to be made in order to have a more organized repo and easier to mantain. No kexts needed from in /S/L/E/ nor in /L/E/.

* The procedure to install is almost identical as with Mojave apart that I am using a different audio solution for ALC256 jack noise on Catalina.
* Found out that using CPUFriend to allow the CPU to go down to 0.8Ghz leaves similar result in battery as simply injecting plugin-type=1 and letting macOS manage the CPU itself.
* Updated every possible driver.
* Tested SMBIOS MacBookPro15,1 as they are sold with better processors than MBP15,2 (which only comes with integrated graphics) and determined that MBP15,2 is the way to go as it only has iGPU you can use a TB3 to HDMI adapter to mirror to an external display which is not possible with MBP15,1 which comes with dual gpu (not even by setting pmset gpuswitch to 0).
* Created proper files to enable native HiDPI on this laptop. Is it gonna make your laptop logo look bigger when booting which is totally fine for me to enable these tasty resolutions if you are good with that. (I personally love using the resolution which makes UI look like 1440 x 810 but it is actually rendering double quantity of pixels 2880 x 1620) You could also use other HiDPI resolutions like 1280x720 or 1680x945.
* I have hidden the macOS reovery partition to get a clean clover boot, if you need it modify the clover config file. Here's how clean it looks:

![clover-theme-minimal-dark](https://i.imgur.com/zGbHRCo.png)

You can install everything by using my Mojave guide for now (note that the Clover folder can now be used for both pre and post installation); but of the tricky HiDPI files because of macOS Catalina is being installed in a separate volume and automatically enabling SIP.

First you need to make sure you create a macOS USB by using the installer from the AppStore as we need to enter macOS recovery (otherwise it will not allow you to diable SIP while logged; according to terminal, only on recovery) and some software tend to remove it.

Let's start by shutting down the computer and booting again, but this time, boot into Recovery from Clover's boot screen.

**There is a script for ease installation of both audio solution for jack noise and HiDPI files.**

**Using the script:** 
Scroll up and click clone or download, then click Download ZIP. Now browse into the master folder and run the Install.command within the Jack_Fix folder and then reboot!

Note that the script expects the **Hackintosh-macOS-Catalina-on-Dell-G7-7588-master** folder in **~/Downloads/**

**Enable native HiDPI resolutions manually:**
Wait for it to boot. Then go to the Utilities tab located at the top and launch terminal. 

Now enter the following commands:

	csrutil disable
	
You are safe to reboot now, when logged go to terminal and type (because even with SIP disabled macOS system files are in a read-only volume):
	
	sudo mount -uw /
	killall Finder
	
Fine, we now need to place the files at:

	/System/Library/Displays/Contents/Resources/Overrides/

After navigating to the folder above look for the Icons.plist file and rename it to IconsBackup.plist

Copy the included folder and Icon.plist file included in the repo and reboot! You can now go to Settings -> Displays and choose scale resolution to pick the one that suits you.

Reboot (you may not have audio, nor trackpad working for now), so repair kextcache with:

	sudo kextcache -i /
	
If no trackpad and/or audio repair kextcache one again and restart.

Finally reboot again and you will be set up!

* Note that every time you reboot the operating system will change the system volume to read-only again so make sure to run the proper commands if you want to modify again it later. 

* Also remember it is healthy to rebuild cache every time that you Hackintosh is updated.

**Appreciate the work and want to donate?** [PayPal](<https://www.paypal.me/juanvasquezcastro>)


Enjoy you new ~~Mac~~ Hackintosh!

## Credits

* Apple for macOS
* The Clover team
* VoodooI2C team
* Rehabman
* vit9696
* PMheart
* EliteMacx86
