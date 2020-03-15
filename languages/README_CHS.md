<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### 语言: [English](../README.md), [俄语](./README_RUS.md), [繁体中文](./README_CHT.md), [简体中文](current)
内核二进制修补程序，在 macOS 上启用 AMD CPU 支持。
### 功能
- 让 macOS 可在 AMD 处理器上运行
- 启用 iMessage, Siri, FaceTime, Continuity 等等.
- 相比 XNU kernel 更为稳定

### 缺点
- 在 macOS 10.14 以下没有 32-bit 支持 (OPEMU)

### 支持的 AMD CPU
| 家族 | 架构| 例子 |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX 系列|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A 系列 (包括 AM4 的 A- 系列) |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h) | Zen | Ryzen, Threadripper, Athlon 2xxGE | <br />

### 支持的 macOS 版本
- High Sierra (高山脊) 10.13.x
- Mojave (莫哈维) 10.14.x
- Catalina (卡塔琳娜) 10.15.x

### 指南
- 从App Store下载 macOS High Sierra, Mojave 或者 Catalina
- 插入一个空的 USB 驱动器
- 在终端中运行以下命令之一，以准备可引导的macOS USB。
```
注意: 确保在以下命令中将 "MyVolumeName" 替换为您的实际 USB 卷名称。

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- 在USB驱动器上安装 OpenCore (有关 OpenCore 版本，请参阅：https://github.com/acidanthera/OpenCorePkg/releases)
- 阅读 [OpenCore 说明书](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) 以设置 `config.plist` ，不提供默认配置
- 根据您的CPU系列 (即 `15h_16h` 或 `17h` ) 将提供的补丁合并到OpenCore `config.plist` 中，然后根据需要进行编辑。

### 特别说明
- 这些补丁需要 OpenCore 0.5.2 及更高版本。 它们不适用于 0.5.1 及以下版本。
- 如果你在设定 OpenCore config 时需要协助，阅读 OpenCore 的官方文件和[这个教学](https://khronokernel-2.gitbook.io/opencore-vanilla-desktop-guide/)或加入 Discord 伺服器
- 对于安装 macOS Mojave 的 15h_16h CPU 系列用户：
  - 在第一次启动 macOS Mojave 时，系统会在「资料及隐私权」画面重新启动。到[这里](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) （UPDATE-2 标题下方）去阅读解决方法
  - 在macOS Mojave 中，某些网站（例如brew.sh, facebook.com 等）可能会在加载时出现错误。到[这里](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) （UPDATE-5 标题下方）去阅读解决方法
- 要启动10.15，需要注意两点：
  - 如果在你的 DSDT 中，有 ID 为 `PNP0C09` 的 EC 装置，macOS 可能在初始启动时卡住。请确保把 EC 装置传回状态 `Zero` 以关闭它，你可以使用一个定制的 [SSDT-EC0.aml](../Extra/SSDT-EC0.aml) 达到以上的效果。如果你想知道这是如何运作的，你可以到[这里](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33). <br> -或- <br> 使用以下ACPI 补丁以更改EC 装置的ID:
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - 当使用这些 SMBIOSes `MacPro6,1`, `MacPro7,1`, 或者 `iMacPro1,1`, `AppleIntelMCEReporter.kext` macOS 可能会 panic. 为了防止这种情况，您需要使用其他SMBIOS或使用 [此kext](../Extra/) 来关闭它.

### 鸣谢
- [AlGrey](https://github.com/AlGreyy) 提出想法并制作补丁
- [XLNC](https://github.com/XLNCs) 加入更多 macOS 版本
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee 和更多人，分享他们对 AMD/XNU 内核的认识 
- [0xD81CF](https://github.com/0xD81CF) 和 [doesprintfwork](https://github.com/doesprintfwork) README 翻译
