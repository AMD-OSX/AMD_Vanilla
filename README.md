<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### Languages: English (current), [Russian](languages/README_RUS.md), [Traditional Chinese](languages/README_CHT.md)
Kernel binary patches to enable almost native AMD CPU support on macOS.

### Features
- Enables macOS to run on AMD CPUs on the fly.
- Enables iMessage, Siri, FaceTime, Continuity etc.
- Stable compared to custom XNU kernel.

### Disadvantages
- No 32-bit support (OPEMU) in 10.14 and lower

### Supported AMD CPU's
| Family | Codename| Example |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A Series (including AM4 A-Series) |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h) | Zen | Ryzen, Threadripper, Athlon 2xxGE | <br />

### Supported macOS versions
- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x

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
- Install OpenCore on your USB drive. (For OpenCore releases see: https://github.com/acidanthera/OpenCorePkg/releases)
- Read the [OpenCore Documentaion](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) for `config.plist` setup. A default config will not be provided.
- Merge the patches provided, according to your CPU family (i.e `15h_16h` or `17h`) into your OpenCore `config.plist` and edit it as per your needs.

### Special Notes
- These patches require OpenCore 0.5.2 and above. They will not work with 0.5.1 and below.
- For support creating OpenCore config read the docs and visit [this](https://khronokernel-2.gitbook.io/opencore-vanilla-desktop-guide/) guide or the Discord server.
- For 15h_16h CPU family users on macOS Mojave:
  - Upon booting to macOS Mojave for first time, the system will reboot after the Data & Privacy screen. To fix this issue follow the procedure mentioned [here](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) under UPDATE-2 heading.
  - On macOS Mojave certain webpages will crash upon loading (eg. brew.sh, facebook.com). To fix this issue follow the procedure mentioned [here](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) under the UPDATE-5 heading.
- To boot 10.15 two things needs to be taken care of:
  - If you have an EC device with ID `PNP0C09` in your DSDT then macOS might get stuck while booting at the initial stage. To fix that you need to make sure your EC device is disabled by making it return status `Zero`. You can use a custom [SSDT-EC0.aml](./Extra/SSDT-EC0.aml) to do that and if you want to see how it works you can refer to [here](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33). <br> -or- <br> You can change the ID of the EC device. Using this ACPI patch:
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - When using the SMBIOSes `MacPro6,1`, `MacPro7,1`, or `iMacPro1,1`, `AppleIntelMCEReporter.kext` macOS might panic. To prevent this you need to either use a different SMBIOS or use a disabler kext from [here](./Extra/).

### Credits
- [AlGrey](https://github.com/AlGreyy) for the idea and creating the patches.
- [XLNC](https://github.com/XLNCs) for maintaining patches to various macOS versions.
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee and many others for sharing their AMD/XNU kernel knowledge
- [0xD81CF](https://github.com/0xD81CF) and [doesprintfwork](https://github.com/doesprintfwork) for readme translations.
