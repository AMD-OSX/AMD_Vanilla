
AMD Vanilla Clover
==========
Kernel binary patches to enable native AMD CPU support on macOS.

### Features
- Enables macOS to run on AMD CPUs on the fly.
- Enables iMessage, Siri, FaceTime, Continuity etc.
- Stable compared to custom XNU kernel.

### Disadvantages
- No 32-bit support (OPEMU) in 10.14 and lower

### Supported AMD CPU's
| Family | Codename| Example |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/15h_16h)  | Jaguar | A Series |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/17h) | Zen | Ryzen, Threadripper, Athlon 2xxGE | <br />

### Supported macOS versions
- High Sierra 10.13.6 (17G65, 17G66, 17G8030, 17G8037)
- Mojave 10.14.6 (18G84, 18G87, 18G95, 18G103)
- Catalina 10.15.0 (19A583, 19A602), 10.15.1 (19B88)

### Instructions
- Download macOS High Sierra, Mojave or Catalina from the App Store.
- Plug in an empty USB drive.
- Run one of the below commands in your Terminal to prepare the bootable macOS USB.
```
NOTE: Make sure to replace 'MyVolumeName' with your actual USB volume name in the below commands.

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- Install Clover on your USB drive.
- Place the `config.plist` provided, according to your CPU family (i.e `15h_16h` or `17h`) in your USB EFI Clover folder `EFI/EFI/CLOVER/` and edit it as per your needs.
  Note: If your are making your own Clover config, use `patches.plist` and merge the patches manually.
- Place the required kext according to your system in your USB EFI kexts folder `EFI/EFI/CLOVER/kexts/Other/`.

### Special Notes
- For 15h_16h CPU family users on macOS Mojave:
  - Upon booting to macOS Mojave for first time, the system will reboot after the Data & Privacy screen. To fix this issue follow the procedure mentioned [here](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) under UPDATE-2 heading.
  - On macOS Mojave certain webpages will crash upon loading (eg. brew.sh, facebook.com). To fix this issue follow the procedure mentioned [here](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) under UPDATE-5 heading.
- To boot 10.15 two things needs to be taken care of:
  - If you have an EC device with ID `PNP0C09` in your DSDT then macOS might get stuck while booting at the initial stage. To fix that you need to make sure your EC device is disabled by making it return status `Zero`. You can use a custom [SSDT-EC0.aml](./Extra/SSDT-EC0.aml) to do that and if you want to see how it works then refer [here](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33). <br> -or- <br> You can change the ID of the EC device. Use this ACPI patch:
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - If using SMBIOS `MacPro6,1`, `MacPro7,1`, or `iMacPro1,1`, `AppleIntelMCEReporter.kext` might panic. To prevent that you need to either use a different SMBIOS model or use a disabler kext from [here](./Extra/).

### Credits

- [AlGrey](https://github.com/AlGreyy) for the idea and creating the patches.
- [XLNC](https://github.com/XLNCs) for maintaining patches to various macOS versions.
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee and many others for sharing their AMD/XNU kernel knowledge 
