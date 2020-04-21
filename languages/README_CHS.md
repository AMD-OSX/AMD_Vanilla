<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### 语言: [English](../README.md),, [Russian](languages/README_RUS.md), [Traditional Chinese](languages/README_CHT.md), [Spanish](languages/README_ES.md), 简体中文（当前）

通过对内核扩展驱动的二进制修补，使 macOS 提供近乎于原生的 AMD CPU 支持。

### 优点

- 让 macOS 可以在 AMD CPU 上流畅运行
- 支持 iMessage、Siri、FaceTime、Continuity 等功能
- 相比第三方 XNU 内核，二进制修补的方法更稳定更安全

### 缺点

- 即使 macOS 版本小于等于 10.14 也无法支持 32 位（OPEMU）程序

### 兼容的 AMD CPU 列表

| 家族 | 架构 | 例子 |
|------|------|------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX 系列 |
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A 系列 (包括 AM4 的 A- 系列) |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h) | Zen | Ryzen, Threadripper（线程撕裂者）, Athlon 2xxGE | <br />

### 兼容的 macOS 版本

- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x

### 指南

- 从 App Store 下载 macOS High Sierra, Mojave 或者 Catalina 的安装镜像
- 插入一个空的 USB 驱动器
- 在终端中运行下述命令中的一条，准备可以引导的 macOS USB：

```bash
# 注意：确保在将以下命令中的 MyVolume 换成 USB 实际的卷名称

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```

- 在 USB 驱动器上安装 OpenCore（OpenCore 版本列表： https://github.com/acidanthera/OpenCorePkg/releases）。
- 阅读 [OpenCore Documentaion](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) 学习如何配置 `config.plist`。OpenCore 不提供默认配置文件。

> 注：对于简体中文用户可阅读非官方维护的 [OpenCore 参考手册的简体中文翻译](https://skk.moe)。

- 根据你的 CPU 架构（即 `15h_16h` 或 `17h`）将仓库内的补丁合并到 `config.plist` 中，然后根据需要进行修改。

### 特别注意

- 这些补丁不适用于 OpenCore 0.5.1 及以下版本，需要升级到 OpenCore 0.5.2 才可以使用。
- 如果你在配置 OpenCore 的配置文件时遇到了困难，可以阅读 [OpenCore Vanilla Guide](https://khronokernel-2.gitbook.io/opencore-vanilla-desktop-guide/) 提供的教程。

> 注：简体中文用户可阅读由黑果小兵编写的 [精解 OpenCore](https://blog.daliansky.net/OpenCore-BootLoader.html)

- 对于安装 macOS Mojave 的 15h_16h CPU 系列用户：
  - 第一次启动 macOS Mojave 时，系统会在「资料及隐私权」画面重新启动。请前往 [这里](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) （UPDATE-2 标题下方）阅读解决方法。
  - 使用 macOS Mojave 时，浏览器在访问某些网站（例如 brew.sh, facebook.com 等）可能会在加载时崩溃。请前往 [这里](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) （UPDATE-5 标题下方）阅读解决方法。
- 如果你要启动 macOS Catalina，需要注意以下两点：
  - 如果在你的 DSDT 中 EC 下有 HID 为 `PNP0C09` 的设备，那么在引导时可能会卡住。请将该设备的 `_STA` 置零以禁用该设备。你可以使用一个定制的 [SSDT-EC0.aml](./Extra/SSDT-EC0.aml) 解决这个问题。如果你对这个 SSDT 的原理感兴趣，请前往 [这里](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33) 查看原始的 dsl 文件。
  - 或者，你也可以通过 DSDT 重命名的方式改变该设备的 HID：
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - 如果你的 SMBIOS 机型设置为 `MacPro6,1`, `MacPro7,1`, 或者 `iMacPro1,1` 时，macOS 可能会因为 `AppleIntelMCEReporter.kext` 而崩溃，为了避免崩溃你可能需要修改你的 SMBIOS 机型或者安装 [一个 kext](../Extra/)。

### 鸣谢

- [AlGrey](https://github.com/AlGreyy) 提出想法并制作补丁
- [XLNC](https://github.com/XLNCs) 提供更多 macOS 版本支持
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee 和更多人，分享他们对 AMD/XNU 内核的支持
- [0xD81CF](https://github.com/0xD81CF)、[doesprintfwork](https://github.com/doesprintfwork) 和 [Sukka](https://github.com/SukkaW) 提供了对 README 翻译
