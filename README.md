<span align="center">

# AMD Vanilla OpenCore

</span>

### :warning: Patches for beta versions are provided, but no support is given until the OS is released.
### :warning: Try these patches at your own risk, and always keep an EFI backup.

### Languages: English (current)

Binary kernel patches to enable almost native AMD CPU support on macOS.


# Read me first!

Patches are now universal across `15h`, `16h`, `17h`, and `19h` by utilizing the OpenCore kernel Quirk `ProvideCurrentCpuInfo`. [OpenCore](https://github.com/acidanthera/OpenCorePkg/releases) 0.7.1 or newer is required.

Make sure to ****enable**** this quirk or the system ****won't boot****.

> :warning: **Note for Zen 4:** Zen 4 (Ryzen 7000) requires patching for IOPCIFamily.kext. <br/>
> This patch is enabled by default. Please ensure that you've added it to your current config for Zen 4 stability. 
> This patch also allows MSI A520, B550, and X570 boards to boot macOS Monterey and newer.

The Core Count patch needs to be modified to boot your system. Find the three `algrey - Force cpuid_cores_per_package` patches and alter the `Replace` value only.

Change `B8000000 0000`/`BA000000 0000`/`BA000000 0090` to `B8 <Core Count> 0000 0000`/`BA <Core Count> 0000 0000`/`BA <Core Count> 0000 0090`, substituting `<Core Count>` with the hexadecimal value matching your physical core count. Do not use your CPU's thread count.

> :warning: **Note:** *The three different values reflect the patch for different versions of macOS. Be sure to change all three if you boot from macOS 10.13 to macOS 12*

See the table below for the values matching your CPU core count.

| Core Count | Hexadecimal |
|:----------:|:-----------:|
|   4 Core   |     `04`    |
|   6 Core   |     `06`    |
|   8 Core   |     `08`    |
|   12 Core  |     `0C`    |
|   16 Core  |     `10`    |
|   24 Core  |     `18`    |
|   32 Core  |     `20`    |

So for example, a user with a 6-core processor should use these `Replace` values: `B8 06 0000 0000`/`BA 06 0000 0000`/`BA 06 0000 0090`

---


## Features

:heavy_check_mark: Enables macOS to run on AMD CPUs on the fly.

:heavy_check_mark: Enables iMessage, Siri, FaceTime, Continuity, etc.

:heavy_check_mark: Stable compared to a custom XNU kernel.


## Disadvantages

:x: No 32-bit support (OPEMU) in 10.14 and lower


## Supported AMD CPUs

|     Family    |  Codename |              Example              |
|:-------------:|:---------:|:---------------------------------:|
|      15h      | Bulldozer |             FX Series             |
|      16h      |   Jaguar  | A Series (including AM4 A-Series) |
|  17h and 19h  |    Zen    | Ryzen, Threadripper, Athlon 2xxGE |


## Information on the PAT fix patch

- The default-enabled patch is ***Algrey's original patch***. This will work for all GPUs and won't affect audio, but it won't improve performance.

- The other choice is ***Shaneee's patch***, which will increase GPU performance on AMD GPUs but can prevent NVIDIA GPUs from booting. It might also cause audio issues when using HDMI or DisplayPort audio.

The choice is yours. ***Don't try to use them both at the same time!***


## Note on TRX40 systems

Both `mtrr_update_action - fix PAT` patches are not required on TRX40 systems. Disabling them will result in GPU performance improvements. Test this configuration on a USB drive first in preparation for the unlikely event that something goes wrong. Proceed at your own risk.


## Supported macOS versions

- [macOS High Sierra](https://en.wikipedia.org/wiki/MacOS_High_Sierra) (10.13)

- [macOS Mojave](https://en.wikipedia.org/wiki/MacOS_Mojave) (10.14)

- [macOS Catalina](https://en.wikipedia.org/wiki/MacOS_Catalina) (10.15)

- [macOS Big Sur](https://en.wikipedia.org/wiki/MacOS_Big_Sur) (11)

- [macOS Monterey](https://en.wikipedia.org/wiki/MacOS_Monterey) (12)

- [macOS Ventura](https://en.wikipedia.org/wiki/MacOS_Ventura) (13)


## Instructions

Follow the [Dortania OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/) for instructions on how to create the installer USB and set up the config file with these patches.

Do not ask for support on GitHub.


## Special notes

- Use the [latest release of OpenCore](https://github.com/acidanthera/OpenCorePkg/releases/latest) to avoid incompatibilities.

- For support creating OpenCore config read the docs and visit the [guide](https://dortania.github.io/OpenCore-Install-Guide/) or the [Discord server](https://discord.gg/EfCYAJW).

- For 15h_16h CPU family users on macOS Mojave:

  - Upon booting to macOS Mojave for the first time, the system will reboot after the Data & Privacy screen. To fix this issue, follow the procedure mentioned [here](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) under the UPDATE-2 heading.

  - On macOS Mojave, certain webpages will crash upon loading (e.g. brew.sh, facebook.com). To fix this issue, follow the procedure mentioned [here](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) under the UPDATE-5 heading.


## Credits

- [AlGrey](https://github.com/AlGreyy) for the idea and creating the patches.

- [XLNC](https://github.com/XLNCs) for maintaining patches for various macOS versions.

- [Acidanthera](https://github.com/acidanthera) for OpenCore.

- [CaseySJ](https://github.com/CaseySJ/) for Zen 4 IOPCIFamily patch.

- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, [Shaneee](https://github.com/Shaneee), and many others for sharing their AMD/XNU kernel knowledge.
