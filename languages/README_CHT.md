<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### 語言（Languages）: [English](../README.md), [Russian](./README_RUS.md), 繁中（已選）
用於在 macOS 中啟用*差不多*原生的 AMD 處理器支援的內核補丁

### 功能
- 讓 macOS 可在 AMD 處理器上運行
- 啟用 iMessage, Siri, FaceTime, 接續互通等
- 較定制的 XNU kernel 穩定

### 壞處
- 在 macOS 10.14 以下沒有 32-bit 支援 \(OPEMU\)

### 支援的 AMD 處理器
| 家族 | 架構 | 例子 |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX 系列 |
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A 系列（含 AM4 的 A 系列） |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h) | Zen | Ryzen, Threadripper, Athlon 2xxGE | <br />

### 支援的 macOS 版本
- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x

### 指引
- 從 App Store 中下載 macOS High Sierra, Mojave 或 Catalina
- 插入一隻空的 USB
- 在終端機的執行以下其中一條指令，準備可用於啟動的 macOS USB
```
NOTE: 在以下指令中，記得把 'MyVolumeName' 換成你的 USB 容器名稱

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- 安裝 OpenCore 到你的 USB 上（[按這裡](https://github.com/acidanthera/OpenCorePkg/releases)下載 OpenCore release）
- 根據 [OpenCore Documentation](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) 製作 `config.plist`. **沒有**預設 config
- 根據你的 CPU 家族和需要，在 config 中合併以上提供的補丁和更改你需要的設定

### 特別 Notes
- 這些補丁需要 OpenCore 0.5.2 或以上，在 0.5.1 或以下的版本不能使用
- 如果你在設定 OpenCore config 時需要協助，閱讀 OpenCore 的官方文件和[這個教學](https://khronokernel-2.gitbook.io/opencore-vanilla-desktop-guide/)或加入 Discord 伺服器
- 對於在安裝 macOS Mojave 的 15h_16h 處理器家族
  - 在第一次啟動 macOS Mojave 時，系統會在「資料及隱私權」畫面重新啟動。到[這裡（UPDATE-2 標題下方）](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085)去閱讀解決方法
  - 在 macOS Mojave 中，某些網站（例如 brew.sh, facebook.com 等）可能會在加載時出現錯誤. 到[這裡（UPDATE-5 標題下方）](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857)去閱讀解決方法
- 啟動 10.15 需要注意以下兩個事項：
  - 如果在你的 DSDT 中，有 ID 為 `PNP0C09` 的 EC 裝置，macOS 可能在初始啟動時卡住。請確保把 EC 裝置傳回狀態 `Zero` 以關閉它，你可以使用一個定制的 [SSDT-EC0.aml](../Extra/SSDT-EC0.aml) 達到以上的效果。如果你想知道這是如何運作的，你可以到[這裡](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33). <br> -或- <br> 使用以下 ACPI 補丁以更改 EC 裝置的 ID:
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - 當使用這些 SMBIOS：`MacPro6,1`、`MacPro7,1` 或 `iMacPro1,1` 時， `AppleIntelMCEReporter.kext` 會出現錯誤 \(Kernel Panic\)。你可以使用其他的 SMBIOS 或到[這裡](../Extra/)下載並使用可關閉它的 kext (AppleMCEReporterDisabler.kext)

### 鳴謝
- [AlGrey](https://github.com/AlGreyy) - 想法及製作這些補丁
- [XLNC](https://github.com/XLNCs) - 加入更多 macOS 版本
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee 和更多人 - 分享他們對 AMD/XNU 內核的知識
- [0xD81CF](https://github.com/0xD81CF) 和 [doesprintfwork](https://github.com/doesprintfwork) - README 翻譯
