<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### 语言: [English](../README.md), [Russian](./README_RUS.md), [Traditional Chinese](languages/README_CHT.md), [Spanish](languages/README_ES.md), 简体中文(当前选中)
内核二进制补丁，使macOS近乎原生支持AMD CPU

### 功能
- 使macOS能够在AMD CPU上飞速运行
- 启用iMessage、Siri、FaceTime、Continuity等功能
- 与定制的XNU内核相比更稳定

### 缺点
- 10.14及以下版本不支持32位（OPEMU）

### 支持的AMD CPU
| 家族 | 代号 | 示例 |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | 推土机 | FX系列 |
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A系列（包括AM4 A系列） |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h) | Zen | Ryzen, Threadripper, Athlon 2xxGE | <br />

### 支持的macOS版本
- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x

### 说明
- 从App Store下载MacOS High Sierra、Mojave或Catalina
- 插入一个空的USB驱动器
- 在你的终端机上运行以下命令来准备可启动的macOS USB
```
注意：请确保在以下的命令中用实际的USB卷名替换'MyVolumeName'

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- 将OpenCore安装到您的USB驱动器上(OpenCore的版本见：https://github.com/acidanthera/OpenCorePkg/releases)
- 请阅读[OpenCore Documentaion](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf)中关于`config.plist`的设置，我们不会提供默认的配置
- 根据你的CPU系列(即`15h_16h`或`17h`)，将提供的补丁合并到你的OpenCore `config.plist` 中，并根据你的需要进行编辑

### 特别说明
- 这些补丁需要OpenCore 0.5.2及以上版本,它们无法在0.5.1及以下版本中使用
- 在 OpenCore 配置时需要支持，请阅读文档并访问 [这里](https://khronokernel-2.gitbook.io/opencore-vanilla-desktop-guide/) 指南或 Discord 服务器
- 对于macOS Mojave上的15h_16h CPU系列用户
  - 第一次启动到macOS Mojave时，系统会在数据和隐私屏幕后重启。要解决这个问题，请按照UPDATE-2标题下[这里](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085)提到的步骤进行
  - 在macOS Mojave上，某些网页在加载后会崩溃（例如：brew.sh，facebook.com）。要解决这个问题，请按照UPDATE-5标题下提到的[这里](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857)的程序进行
- 要启动10.15，有两件事需要注意
  - 如果你的DSDT中有一个ID为 `PNP0C09` 的EC设备，那么macOS在初始阶段启动时可能会卡住。要解决这个问题，你需要确保你的EC设备被禁用，让它返回状态`Zero`。你可以使用一个自定义的[SSDT-EC0.aml](./Extra/SSDT-EC0.aml)来实现，如果你想看看它是如何工作的，你可以参考[这里](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33)。<br> -或- <br> 你可以改变EC设备的ID。使用这个ACPI补丁
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - 当使用这些SMBIOS: `MacPro6,1`, `MacPro7,1`, 或`iMacPro1,1`, `AppleIntelMCEReporter.kext` 时，macOS可能会崩溃。为了防止这种情况，你需要使用不同的SMBIOS或使用[这里](./Extra/)的disabler kext

### 鸣谢
- [AlGrey](https://github.com/AlGreyy)，感谢他的创意和创建补丁
- [XLNC](https://github.com/XLNCs)，感谢他维护各种macOS版本的补丁
- Sinetek、Andy Vandijck、spakk、Bronya、Tora Chi Yo、Shaneee和其他许多分享AMD/XNU内核知识的人
- [0xD81CF](https://github.com/0xD81CF), [dosprintfwork](https://github.com/doesprintfwork) 和 [erikjara](https://github.com/erikjara) 的readme翻译
