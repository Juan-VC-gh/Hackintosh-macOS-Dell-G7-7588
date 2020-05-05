# <p align="center">This guide is only for Dell G7 7588!<br/><br/>

<p align="center">
	<img src="https://iili.io/JCfJ3u.png" width="200" height="48"/>
</p>

-----
	
## What is OpenCore?

OpenCore is no more than the most advanced and complex to setup bootloader for a PC. If feeling curious and/or adventurous, check the excellent-written [official OpenCore documentation](https://github.com/acidanthera/OpenCorePkg/raw/master/Docs/Configuration.pdf). There is really no better explanation of the bootlader and it's advantages than the one from _khronokernel_:

> OpenCore is an open-source unconventional first-in-class piece of software designed to intercept kernel loading to insert a highly advanced rootkit, designed to be an alternative to Clover. OpenCore aims to resolve the constraints and issues imposed by Clover by providing a more versatile and modular system. While OpenCore is primarily designed for Hackintosh systems, it can be used in any scenario where an emulated EFI is needed with many using it on KVMs and real Macs
	
## System information:

* Laptop model: Dell G7 7588
* CPU: Intel Core i7-8750H (base freq: 2.2GHz, 2-core turbo boost up to 4.1GHz, 2-core boost up to 4.0GHz and 2-core boost up to 3.9GHz)
* RAM: 2x 8GB DDR4 @ 2666MHz
* GPU: Intel UHD 630 (Nvidia card disabled with an ACPI call. It is not supported)
* Disks: 1x 512GB Adata XPG Gammix S11 Pro (NVMe) + 1x 1TB Mechanical Drive
* Audio Codec: ALC256 (3246)
* Wifi/Bluetooth: BCM94352Z (part: 08XRYC)
* Ethernet: Qualcomm Athernos Killer E2400

The above configuration is my current setup. I have only switch the NVMe drive and the wifi/bt card. Any NVMe will most likely work while for wireless networking there are not much good options, check the guide for more info. The guide should also work for the i5 laptop variant (battery will not probably last as long), remove CPUFriend.kext and CPUFriendDataProvider.kext inside OC/Kexts. 

## Guide

For a more friendly reading experience the guide is now hosted [here](https://juan-vc.github.io/oc-g7-guide/) supports fonts, sizes and white/dark/sepia mode.

## Support me

**Guides are time consuming, ff you appreciate the work and want to support me ->** [PayPal](<https://www.paypal.me/juanvasquezcastro>)