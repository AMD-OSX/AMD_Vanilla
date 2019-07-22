
AMD Vanilla
==========
Kernel binary patches to enable native AMD CPU support on macOS.

### Features
- Enables macOS to run on AMD CPUs on the fly.
- Enables iMessage, Siri, Facetime, etc.
- Enables HandOff, Continuity etc.
- Faster releases compared to open source kernel

### Disadvantages
- No 32-bit app support (i.e No OPEMU)

### Supported AMD CPU's
| Family | Codename| Example |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/15h_16h)  | Jaguar | A Series |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/17h) | Zen, Zen+, Zen 2 | Ryzen, Threadripper, Athlon 2xxGE | <br />

### Supported macOS versions

**`For 15h_16h CPU's :`**

- High Sierra 10.13.6 (17G65, 17G66, 17G6029, 17G6030, 17G7024)
- Mojave 10.14.4 (18E226,18E227), 10.14.5 (18F132)

**`For 17h CPU's :`**

- High Sierra 10.13.6 (17G65, 17G66, 17G5019, 17G6029, 17G6030, 17G7024)
- Mojave 10.14.1, 10.14.3, 10.14.4 (18E226,18E227), 10.14.5 (18F132)


### Instructions

#### Method I

`NOTE : Includes only patches.`
- Grab the `patches.plist` file according to your CPU family model , provided in respective `15h_16h` or `17h` CPU family folders.
- Open the `patches.plist` file with a text editor and copy the patches manually to your existing clover `config.plist` which is located in `EFI/EFI/CLOVER/`
- Save and Done.

#### Method II

- Grab the generic `config.plist` file according to your CPU family model , provided in respective `15h_16h` or `17h` CPU family folders.
- Open it with Text Editor and edit it according to your macOS system needs.
- Save it in `EFI/EFI/CLOVER/` and Done.

### Credits

- [AlGrey](https://github.com/AlGreyy) for the idea and creating the patches.
- [XLNC](https://github.com/XLNCs) for maintaining 15h_16h patches to various macOS versions.
