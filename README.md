<span align="center">

# AMD Kernel Patches for OpenCore
###### Try these patches at your own risk, and always keep an EFI backup.

Binary kernel patches to enable almost native AMD CPU support on OS X.

Support Chart

| Release Name | Status | Notes |
| --- | --- | --- |
| Sierra | <span style="color: #ffe985;">Work-In-Progress</span> | cpuid_cores_per_package patch may not be working properly.<br>Currently Kernel Panics. |
| El Capitan | <span style="color: #a80000;">Incomplete</span> | None |
| Yosemite | <span style="color: #a80000;">Incomplete</span> | None |
| Mavericks | <span style="color: #a80000;">Incomplete</span> | None |
| Mountain Lion | <span style="color: #a80000;">Incomplete</span> | None |
| Lion | <span style="color: #a80000;">Incomplete</span> | None |
| Snow Leopard | <span style="color: #a80000;">Incomplete</span> | None |
| Leopard | <span style="color: #a80000;">Incomplete</span> | None |
| Tiger | <span style="color: #a80000;">Incomplete</span> | None |

# Preliminary Info

Ensure the Kernel Quirk `ProvideCurrentCpuInfo` is enabled. OpenCore 0.7.1 or newer is required. You should NOT be using an outdated copy of OpenCore, this requirement has long been deprecated. Make sure to **enable** this quirk or the system **won't boot**. You're only warned once.

### Note for Zen 4:

We do not have any people on Zen 4 available for testing at this moment, no official support is provided at this time. Zen 3 FTW (not really, give us time).

### Configuring cpuid_cores_per_package patch.

The Core Count per Package patch needs to be modified to boot your system. The first kernel patch is the required to be updated. Update the `Replace` value only.

| OS X Version | Replace Value | New Value |
|----------------------|---------------|-----------|
| 10.12.xx | B8000000 0000 | B? < Core Count > 0000 0000 |

From the table above substitue `< Core Count >` with the hexadecimal value matching your physical core count. Do not use your CPU's thread count. See the table below for the values matching your CPU core count.

| Core Count | Hexadecimal |
|------------|-------------|
|   4 Core   |     `04`    |
|   6 Core   |     `06`    |
|   8 Core   |     `08`    |
|   12 Core  |     `0C`    |
|   16 Core  |     `10`    |
|   24 Core  |     `18`    |
|   32 Core  |     `20`    |

## Features

- Enables OS X to run on AMD CPUs without a custom built kernel.

- Bridges the missing OS X releases that were missing from AMD support.

## Disadvantages

- No 32-bit support (OPEMU) in 10.14 and lower, practically every version here.

## Supported AMD CPUs

|     Family    |  Codename |              Example              |
|---------------|-----------|-----------------------------------|
|      15h      | Bulldozer |             FX Series             |
|      16h      |   Jaguar  | A Series (including AM4 A-Series) |
|  17h and 19h  |    Zen    | Ryzen, Threadripper, Athlon 2xxGE |

## Credits

- [AlGrey](https://github.com/AlGreyy) for the idea and creating the patches.

- [XLNC](https://github.com/XLNCs) for maintaining patches for various macOS versions.

- [Acidanthera](https://github.com/acidanthera) for OpenCore.

- [CaseySJ](https://github.com/CaseySJ/) for Zen 4 IOPCIFamily patches.

- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, [Shaneee](https://github.com/Shaneee) and many others for sharing their AMD/XNU kernel knowledge.
