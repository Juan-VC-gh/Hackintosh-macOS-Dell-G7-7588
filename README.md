# <p align="center">Dell G7 7588 Hackintosh<br/>
## <p align="center">For obvious reasons like unlocking the Intel MSR 0xE2 registry, Hackintosh is hardware specific. This guide is only for Dell G7 7588!<br/>
	
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
* Ethernet: Qualcomm Atheros Killer E2400

The above configuration is my current setup. I only swapped the NVMe drive and the Intel wifi/bt card. Any NVMe will most likely work while for wireless networking there are not many good options, check the [What works?](https://juan-vc.github.io/oc-g7-guide/what-works/work-notWork.html#what-works) section from the guide for more info.

## Guide

For a more friendly reading experience the guide is now hosted [here](https://juan-vc.github.io/oc-g7-guide/).

## Support me

**Guides are time consuming, if you appreciate the work and want to support me ->** [PayPal](<https://www.paypal.me/juanvasquezcastro>)
