
AMD Vanilla
==========
Kernel binary patches to enable native AMD CPU support on macOS.

### Features

- Enables macOS to run on AMD CPUs on the fly.
- Enables iMessage, Siri, Facetime, Continuity etc.
- Stable compared to custom XNU kernel.

### Disadvantages
- No 32-bit support (No OPEMU)

### Supported AMD CPU's
| Family | Codename| Example |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/15h_16h)  | Jaguar | A Series |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/17h) | Zen | Ryzen, Threadripper, Athlon 2xxGE | <br />

### Supported macOS versions

- High Sierra 10.13.6 (17G65, 17G66, 17G8030, 17G8037)
- Mojave 10.14.6 (18G84, 18G87, 18G95, 18G103)

### Instructions

- Download macOS HighSierra or Mojave from Appstore.
- Plug an empty USB drive.
- Run the below command in your Terminal to prepare bootable macOS USB.

```
NOTE: Make sure to replace 'MyVolumeName' with your actual USB volume name in the below commands.

## HighSierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```

- Install Clover bootloader on your USB drive.
- Place the `config.plist` provided , according to your CPU Family i.e `15h_16h` or `17h` in your USB EFI Clover folder `EFI/EFI/CLOVER/` and edit it as per your needs.

NOTE : If your are making your own clover config then use `patches.plist` to copy the patches manually.

- Place the required Kexts according to your system specs in your USB EFI kexts folder `EFI/EFI/CLOVER/kexts/Other/`
- Done.

### Credits

- [AlGrey](https://github.com/AlGreyy) for the idea and creating the patches.
- [XLNC](https://github.com/XLNCs) for maintaining patches to various macOS versions.
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee and many others for sharing their AMD/XNU kernel knowledge 
