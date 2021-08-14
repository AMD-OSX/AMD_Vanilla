<span align="center">

<h1>AMD Vanilla OpenCore</h1>

</span>


### Patches for Beta versions are provided but no support is given until the OS is released. <br /><br />Try these patches at your own risk and always have a backup EFI to boot.

  

### Languages: English (current)

  

Binary Kernel patches to enable almost native AMD CPU support on macOS.

  

# Read Me First!

Patches are now universal across 15h, 16h, 17h and 19h by utilizing the OpenCore Kernel Quirk `ProvideCurrentCpuInfo`. OpenCore 0.7.1 or newer is required.

Make sure to ****enable**** this quirk or the system ****won't boot****.

This quirk provides the kernel with the CPU frequencies for macOS to boot.

  

Core Count patch needs to be modified to boot your system. Find the three `algrey - Force cpuid_cores_per_package` patches and alter the `Replace` value only.

Changing `B8000000 0000`/`BA000000 0000`/`BA000000 0090`* to `B8 <CoreCount> 0000 0000`/`BA <CoreCount> 0000 0000`/`BA <CoreCount> 0000 0090`* substituting `<CoreCount>` with the hexadecimal value matching your physical core count.

**Note:** *The three different values reflect the patch for different versions of macOS. Be sure to change all three if you boot macOS 10.13 to macOS 12*

See the table below for the values matching your CPU Core Count.

| CoreCount | Hexadecimal|
|--------|---------|
|   4 Core  | `04` |
|   6 Core  | `06` |
|   8 Core  | `08` |
|   12 Core | `0C` |
|   16 Core | `10` |
|   24 Core | `18` |
|   32 Core | `20` |

  So for example a 6 Core 5600X Replace value would result in these replace values, `B8 06 0000 0000`/`BA 06 0000 0000`/`BA 06 0000 0090`

---

Note: MacOS Monterey installation requires `Misc -> Security -> SecureBootModel` to be disabled in the config.<br />Also TPM needs to be disabled in the BIOS. Both can be enabled after install. 

___

  

## Features

- Enables macOS to run on AMD CPUs on the fly.

- Enables iMessage, Siri, FaceTime, Continuity etc.

- Stable compared to custom XNU kernel.

  

## Disadvantages

- No 32-bit support (OPEMU) in 10.14 and lower

  

## Supported AMD CPU's


| Family | Codename| Example |
|--------|---------|----------|
|   15h  | Bulldozer | FX Series|
|   16h  | Jaguar | A Series (including AM4 A-Series) |
|   17h and 19h | Zen | Ryzen, 1st, 2nd + 3rd Gen Threadripper, Athlon 2xxGE |<br />

  

## Information on the PAT fix patch

The default enabled patch is Algrey's original patch. This will work for all GPUs and doesn't affect audio but doesn't improve the performance.

The other choice is Shaneee's patch which will increase GPU performance on AMD GPUs but can stop Nvidia GPUs booting. It also causes audio issues when using HDMI and DP audio.

The choice is yours on which patch to use. Please don't try to use them both at the same time.

  

## Note on TRX40 Systems

Disabling the `mtrr_update_action - fix PAT` patch has shown an improvement in GPU performance on some systems that have tested. If you wish to test this it is recommended to do so on a USB with OpenCore to ensure it works first. There may be issues with different motherboard/GPU combos that we aren't aware of. Proceed at your own risk.

  

## Supported macOS versions

- High Sierra 10.13.x

- Mojave 10.14.x

- Catalina 10.15.x

- Big Sur 11.x

- Monterey 12.x ( No Support until OS Release )

  

## Instructions

- Download macOS High Sierra, Mojave, Catalina, Big Sur or Monterey from the App Store.

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

  

## Big Sur

sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

  

## Monterey

sudo /Applications/Install\ macOS\ Monterey\ Beta.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

```

  

- Install OpenCore on your USB drive. (For OpenCore releases see: https://github.com/acidanthera/OpenCorePkg/releases)

- Read the [OpenCore Documentaion](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) for `config.plist` setup. A default config will not be provided.

- Merge the patches provided into your OpenCore `config.plist` and edit it as per your needs.

  

## Special Notes

- Use the latest Release of OpenCore to avoid incompatibles. Find the latest release [here](https://github.com/acidanthera/OpenCorePkg/releases/latest).

- For support creating OpenCore config read the docs and visit [this](https://dortania.github.io/OpenCore-Install-Guide/) guide or the Discord server.

- For 15h_16h CPU family users on macOS Mojave:

- Upon booting to macOS Mojave for first time, the system will reboot after the Data & Privacy screen. To fix this issue follow the procedure mentioned [here](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) under UPDATE-2 heading.

- On macOS Mojave certain webpages will crash upon loading (eg. brew.sh, facebook.com). To fix this issue follow the procedure mentioned [here](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) under the UPDATE-5 heading.

- To boot 10.15 two things needs to be taken care of:

- If you have an EC device with ID `PNP0C09` in your DSDT then macOS might get stuck while booting at the initial stage. To fix that you need to make sure your EC device is disabled by making it return status `Zero`. You can use a custom [SSDT-EC0.aml](./Extra/SSDT-EC0.aml) to do that and if you want to see how it works you can refer to [here](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33). <br> -or- <br> You can change the ID of the EC device. Using this ACPI patch:

```

Comment Find  Replace

PNP0C09 to PNPFFFF  41D00C09 41D0FFFF

```

- When using these SMBIOS profiles `MacPro6,1`, `MacPro7,1`, or `iMacPro1,1`, `AppleIntelMCEReporter.kext` macOS might panic. To prevent this you need to either use a different SMBIOS or use a disabler kext from [here](./Extra/).

  

## Credits

- [AlGrey](https://github.com/AlGreyy) for the idea and creating the patches.

- [XLNC](https://github.com/XLNCs) for maintaining patches to various macOS versions.

- [Acidanthera](https://github.com/acidanthera) for OpenCore.

- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, [Shaneee](https://github.com/Shaneee) and many others for sharing their AMD/XNU kernel knowledge
