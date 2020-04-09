<p align="center">
	<img src="https://iili.io/JCfJ3u.png" width="200" height="48"/>
</p>

-----
	
## What is OpenCore?

OpenCore is no more than the most advanced and complex to setup bootloader for a PC. If feeling curious and/or adventurous, check the excellent-written [official OpenCore documentation](https://github.com/acidanthera/OpenCorePkg/raw/master/Docs/Configuration.pdf). There is really no better explanation of the bootlader and it's advantages than the one from _khronokernel_:

> OpenCore is an open-source unconventional first-in-class piece of software designed to intercept kernel loading to insert a highly advanced rootkit, designed to be an alternative to Clover. OpenCore aims to resolve the constraints and issues imposed by Clover by providing a more versatile and modular system. While OpenCore is primarily designed for Hackintosh systems, it can be used in any scenario where an emulated EFI is needed with many using it on KVMs and real Macs

## Advantages of OpenCore over Clover

* On average, OpenCore systems boot faster than those using Clover as less unnessary patching is done
* Better overall stability as patches can be much more persise: macOS 10.15.4 update as an example
* OpenCore offers better overall security with better support for FileVault, no need to disable System Integrity Protection(SIP) and even secure boot-like functionality support via Vaulting, which consists of a 256 byte RSA-2048 signature from a `vault.plist` that  will be shoved into `OpenCore.efi`
* OpenCore supports boot hotkey via `boot.efi` - hold `Option` or `ESC` at startup to choose a boot device, `Cmd+R` to enter Recovery or `Cmd+Option+P+R` to reset NVRAM
* OpenCore is designed with the future in mind and uses modern methods to load 3rd party kernel extensions without breaking System Integrity Protection which Clover uses
* BootCamp switching and boot device selection are supported by reading NVRAM variables set by Startup Disk just like a real mac
* Future development for `AptioMemoryFix` (a UEFI driver that fixes memory allocation for macOS) is directly tied to OpenCore, specifically being absorbed into OpenCore itself with the `OpenRuntime.efi` being used as an extension
* UEFI and Legacy boot modes are supported
* More sophisticated patching such as mask patching means macOS updates have very little chance of breaking AMD systems, with AMD OSX patches supporting all versions of High Sierra, Mojave and Catalina. All future AMD OSX development is tied to Opencore, so for 10.15.2+ you'll need OpenCore

## Important things to note about OpenCore

* An ESP partition of at least 200MB is required on the drive macOS will be installed. If you plan to dual/triple boot with the same drive, it's recommended to install macOS first as it creates the ESP of the required size.
* Kernel extensions are loaded in the order specified in your config file, so you must load an extension's dependencies before you load the extension itself.
* SMBIOS data, ACPI patches and DSDT/SSDTs are applied to all operating systems. Modifying the SSDTs to properly adjust the supported ACPI interfaces is recommended. Adjustments are made using the Operating System Interface Level method provided by ASL. An adjustment looks somewhat like: `if (_OSI ("Darwin")) {}`

## What is not working?

* SD card slot
* USB-C
* Hibernation? Not tested, will most likely work with acidanthera's `HibernationFixup` kernel extension
* No HDMI video/audio output. It is controlled by the Nvidia discrete gpu. There are no cuda drivers prior High Sierra (10.13), nor pascal neither turing cards will work. The Nvidia card is disabled by an ACPI call (_OFF) at the device scope (\_SB.PCI0.PEG0.PEGP)

## What works?

* Keyboard with the special keys like volume or brightness control
* Brightness control
* Intel Quartz Extreme and Intel Core Image
* Hardware encoding and decoding for codecs like h.264 and h.265 (HEVC)
* iMessage/FaceTime
* Ethernet
* Trackpad with native macOS gestures (disable smart zoom under Scroll & Zoom to avoid two finger touch delays, also happens on real Macbooks)
* Sound (Internal speakers, internal mic, jack)
* Battery display and manager
* External Thunderbolt 3 displays
* USB ports, have been mapped and injected with a codeless kernel extension (like on a real Mac) to avoid the port limit on macOS
* Sleep
* Native CPU power management - by looking at `PR00` (how the cpu is defined for the laptop according to the ACPI tables) with `IORegistryExplorer` there is the `plugin-type` property with a value of `0x01` which indicates an active CPU PM, `CFG-Lock` has to be disabled, the UEFI provides no option to disable it so it has to be done manually with a modified GRUB shell and the corresponding `CFG-Lock` offset found by extracting the PE32 image section binary from the firmware package which is later converted to a text file.
* Wi-Fi (2.4Ghz and 5Ghz networks) and Bluetooth (AirDrop, Handoff, Auto Unlock) work flawlessly by using a card purchased listed in AliExpress as a `BCM94352Z` with part number: `08XRYC` which carries a bluetooth `vendor-id:0x413C` and `device-id:0x8143`, that means it is a `DW1550` (4352+20702 combo) but sold as a m.2 form factor 2230 rather than a half mini pcie. Other laptop recommended cards to get everything working are `BCM94360NG`, `DW1820A`, `DW1560` or `DW1830`. The `DW1820` is a special case because one needs to manually disabled the Active State Power Management (by injecting the `pci-aspm-default` = `0x0` to the PCIRootAddr of the card) from the PCI Express 2.0 for the card or else you will never boot macOS, will attach a configuration file with the key to disable aspm so one could replace the corresponding property on the OpenCore configuration file to get this low cost card alternative working as the other cards are beign sold expensive due to the fact there are not much m.2 hackintosh cards.
* Simulated native HiDPI by using proper display specific files that need to be placed on the macOS system partition.
* Pretty much every other Mac feature I have forgotten to list or may be problematic when setting up a hackintosh.


## What you need:

* Basic computer knowledge
* Read and Write permissions on the `ESP` partition (believe me, it way easier to modify the `ESP` with either Linux or macOS than with Windows)
* 16+GB USB flash drive.
* A real Mac to obtain and create the macOS installer partition on a usb like one would do for any Mac or any trustworthy way to obtain the base macOS installer ([gibMacOS](https://github.com/corpnewt/gibMacOS) should work but I have never tried it).
* A usb mouse to install macOS because the kernel extension that controls the I2C trackpad requires booting the complete operating system to work.

## rEFInd

Everyone appreciates a good looking friendly software, Clover for example has a lot of themes that make the boot screen look fantastic. Sadly, OpenCore development is tied at the moment to improve performance and add new features, main reason on why there are no themes at the moment for OpenCore as it does not support them, yet. To have a nice looking boot while avoiding potencial issues between operating systems (as noted above, OpenCore does not allow to disable ACPI patching for Windows or Linux) this guide uses `rEFInd` as a chain-loader to achieve both.

My current boot screen looks like this:
![rEFInd_BootScreen](https://iili.io/JCaRgj.png)
			      
-----

## UEFI settings

There are some settings that need to be tweaked before booting the macOS installer, enter the UEFI (continously press F2 after turning on the computer) and from default, set the settings as mentioned:

* UEFI Boot Path Security -> Never
* SATA Operation -> AHCI
* Enabled both usb boot support and external USB port
* Thunderbolt boot support
* Thunderbolt security -> no security
* PTT Security -> Disabled
* Secure Boot Enable -> Disabled
* Intel SGX -> Disabled
* VT for Direct I/O -> Disabled
* Auto OS Recovery Threshold -> Disabled
* SupportAssist OS Recovery -> Disabled

## Building the USB installer

The USB setup should follow the way:
* GUID Partition Map
* 1 Partition
* Mac OS Extended (Journaled)
* macOS installer downloaded from the AppStore

To do this, fire up the Terminal (located in `/Applications/Utilities`) and type `diskutil list`.

This will give you a list of all the connected disks and their partitions. Take note of the disk identifier for your USB drive. DO NOT GUESS THIS AS WE ARE ABOUT TO ERASE IT! Then run the following replacing `disk#` with your actual identifier:

	diskutil partitionDisk /dev/disk# GPT JHFS+ "USB" 100%
	
This will partition the disk as listed above and rename it to "USB".

You can now run the corresponding command from Apple's own instructions - for this example, we'll be using the Catalina command:

	sudo "/Applications/Install macOS Catalina.app/Contents/Resources/createinstallmedia" --volume /Volumes/USB
	
_This will take some time, and it doesn't output much for status updates_. It can take upwards of 30-40 minutes, so just be patient.  Grab a cup of coffee, read the news, catch up with friends and family - you'll be here for a bit

When this completes, you will have a USB installer that can boot on a _real Mac_. We just need to get the Hackintosh-related stuff set up, and we'll be in business!

For those that are timid around the command line - _CorpNewt_ put together a [script](https://github.com/corpnewt/USB-Installer-Creator) awhile back that can perform these actions for you. I have not used it myself though I have used other hackintosh utilities from _CorpNewt_ that are really handy and fully functional like **GenSMBIOS** or **ProperTree**.

## Copying boot files to USB

First run in terminal

	diskutil list
	
Take note of the other partition identifier of the USB (the partition where macOS is not installed). Let's mount it to copy the necessary files.

	sudo diskutil mount /dev/disk#s#
	
Replace the `#` symbols with the corresponding disk indentifier obtained previously.
With the partition mounted, copy the `OC` folder into the **root of the partition**. 

## Manually create a boot entry

The UEFI that ships with the laptop allows creation of simple boot entries, as we do not need to append any boot arguments like when booting a Linux kernel directly, manually browse the partitions and point the boot entry to `OpenCore.efi`.

## Booting the installer

Reorder the boot entries or press F12 at boot to choose the previously created boot entry. When you reach the OpenCore picker, choose the install macOS entry and install the operating system on an APFS partition (create the partition within Utilities -> Disk Utility). You will most likely need a USB mouse because the trackpad will not work.

**Any boot from now on, should be with the USB OpenCore until you configure rEFInd (information on the Booting rEFInd section).** 

## Post installation

By default, when entering sleep, the OS will save the sleep image to RAM and disk, it will hibernate after 24-48h, prevent the hibernation by saving sleep image to RAM only. Run in terminal `sudo pmset -a hibernatemode 0` and we should be done with that.

Finally we will enable HiDPI and fix some audio issues with the jack. Shut down the computer and when in OpenCore picker choose the Recovery entry, when booted disable go to Utilities and lauch the terminal once again, run `csrutil disable` and reboot one more time.

Using Wi-Fi/Ethernet [download](https://github.com/Juan-VC/Hackintosh-macOS-Catalina-on-Dell-G7-7588/archive/master.zip) the master branch as zip.

Fire the terminal to ensure the script that configures HiDPI and jack is executable

	chmod +x ~/Downloads/Hackintosh-macOS-Catalina-on-Dell-G7-7588-master/Jack_Fix/install.command
	
Finally double click the `install.command` found in the `Jack_Fix` folder, enter your user password to allow the script to run and wait for it to finish. Reboot and you will be done setting up OpenCore. Consider using a utility like [GenSMBIOS from CorpNewt](https://github.com/corpnewt/GenSMBIOS) to get a valid serial number and other SMBIOS related data for iMessage/Facetime to work.

## Booting with rEFInd

**Update** Opencore supports themes with the `OpenCanopy.efi` driver introduced in version `0.5.7`

You may not be able to boot Windows or Linux with OpenCore, it requires further work which I am not into at the moment because I also wanted a nice GUI when booting. Mount the ESP or EFI type partition from your drive like it was done when copying boot files to the USB and navigate to the `EFI` folder, inside it, copy and paste the `OC` and `refind` folders.

Create a boot entry that points to `refind_x64.efi` and restart (unplug the USB installation before restarting) to reach the rEFInd boot screen. You will see the Arch Linux, macOS and Windows entries I manually created for rEFInd as the 3 right-most boot entries. Remove any other unwanted entries hitting `ESC` in the rEFInd screen and confirm to hide them. Finally choose the entry with the macOS icon to boot OpenCore picker. Boot macOS for the last time to configure the rEFInd theme properly and make OpenCore boot macOS directly without a picker.

Mount the ESP where rEFInd and OpenCore are located. Modify with your favorite editor lines 6 and 7 of the `refind.conf` removing the # symbols like shown

	hideui singleuser,hints,arrows,label,badges
	showtools shutdown
	
this will prevent hiding boot entries with `ESC` but set the theme as it should be used so take note of this and comment then uncomment the lines later if you need to hide more entries.

Also remove the Arch Linux and/or Windows entry if you do not want it. To remove the Arch Linux entry for example, remove the lines

	menuentry "Arch Linux" {
    	icon /EFI/refind/icons/os_arch.png
    	volume Arch-Linux
    	loader /boot/vmlinuz-linux
    	initrd /boot/initramfs-linux.img
    	options  "root=/dev/sda2 rw add_efi_memmap initrd=/boot/intel-ucode.img"
    	submenuentry "Boot using fallback initramfs" {
         	initrd "/boot/initramfs-linux-fallback.img"
    	}
    	submenuentry "Boot to terminal" {
         	add_options "systemd.unit=multi-user.target"
    	}
	}
	
If you want to go deep into rEFInd read the [official configuration site](https://www.rodsbooks.com/refind/configfile.html).

To hide the OpenCore picker, open the `config.plist` file inside `OC` with a proper plist editor like PlistEdit Pro. Find the `Misc/Boot` child key `ShowPicker` and set it to No/False/0.

**Optional** Remove `config.plist` and rename `config-DW1820A.plist` inside OC to `config.plist` if you are using a DW1820A card for Wi-Fi/BT

**Save the files and restart**

## CFG-Lock

Most motherboard vendors lock the `MSR 0xE2` register, this is known as `CFG-Lock`, vendors might add an option to disable `CFG-Lock` within the UEFI menu, but it is not always the case. The XNU kernel requires access to this register for full CPU power management, Apple clearly has the register unlocked and without it, we need OpenCore kernel patches (setting `AppleCpuPmCfgLock` and `AppleXcpmCfgLock` quirks to `TRUE`, both enabled by default from the files I upload) to boot. It might be an unstable solution depending on the machine and will most likely lead to a partial power management. It is highly recommended to unlock writing the register.

Following [dreamwhite guide](https://github.com/dreamwhite/bios-extraction-guide/tree/master/Dell) you find

	CFG Lock, VarStoreInfo (VarOffset/VarName): 0x5BD

`0x5BD` is the offset of `CFG Lock` boolean bit. **This offset is motherboard specific! Do not attempt to use it with another computer rather than a Dell G7 7588**

Setting this variable value with `0x00` the `CFG Lock` will be disabled, granting access to `MSR 0xE2` registry.

### Set CFG-Lock to 0x00

Place the `modGRUBShell.efi` in the `EFI` folder, it is a good idea to create the `modGRUBShell` folder and place it inside, create a boot entry for the file (if using `rEFInd` it will show you a new boot entry of the modified GRUB shell) otherwise with only `OpenCore` you will need to manually create a new boot entry for it or create it directly from the UEFI menu.

Reboot and boot to the GRUB Shell. When ready to input commands type `setup_var 0x5BD 0x00` and press return. For any other laptop model, replace `0x5BD` with your motherboard specific offset.

The output should

	Looking for Setup variables...
	var name: Setup, var size: 12, var guid: ec87d643-eba4-4bb5 - a1-e5-3f-3e-36-b2-0d-a9
	
	--> GUID does not match expected GUID, taking it nevertheless...
	expected a different size of the Setup variable (got 5799 (0x16a7) bytes). Continue with care...
	successfully obtained "Setup" variable from VSS (got 5799 (0x16a7) bytes).
	offset 0x5bd is: 0x01
	setting offset 0x5bd to 0x00
	grub> _
	
You should now have `CFG-Lock` disabled and can disable both `AppleCpuPmCfgLock` and `AppleXcpmCfgLock` kernel quirks in the `OpenCore` `config.plist` file.

If you cannot boot by only modifying the above kernel quirks it must be due to a XNU kernel panic because without patches, it tries to write `MSR 0xE2`, yet; it cannot.

You could also verify the above by creating a boot entry to `VerifyMsrE2.efi` found in /OC/Tools and checking the last line it outputs is

	This firmware has UNLOCKED MSR 0xE2 register!

If you reached this far, congratulations!

Enjoy you new ~~Mac~~ Hackintosh!

**Guides are time consuming, if you appreciate the work and want to donate ->** [PayPal](<https://www.paypal.me/juanvasquezcastro>)

## Credits

* Apple for macOS
* OpenCore team
* Acidanthera
* VoodooI2C team
* Rehabman
* vit9696
* PMheart
* EliteMacx86
* CorpNewt
* dreamwhite
