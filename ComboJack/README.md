# ComboJack for Dell series
An Pop up to select type of jack that you plug in

<p align="center">
    <img src="./popup.png"/>
</p>

# Support
+ ALC255
+ ALC256
+ ALC295 (Dell Inspiron 7590/7591)
+ ALC298

# Status
+ Currently support only Headset mode and Headphones mode due to my ALC295
+ You can bring it back by comment out below line in hda-verb

```c
    GET_CFSTR_FROM_DICT(Merged, @"btnLinein")
```

# Installation
1. Copy VerbStub.kext into your Clover/kext/Other
2. Run 'bash install.sh' and you good to go.

# Add your codec
+ Go here: https://github.com/torvalds/linux/blob/master/sound/pci/hda/patch_realtek.c
+ Try finding your codec and add it into hda-verb.m in project