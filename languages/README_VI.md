<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### Ngôn ngữ (Languages): [Tiếng Anh (English)](../README.md), [Tiếng Nga (Russian)](./README_RUS.md), [Tiếng Trung Phồn thể (Traditional Chinese)](./README_CHT.md), [Tiếng Tây Ban Nha (Spanish)](./README_ES.md), [Tiếng Trung Giản thể (Simplified Chinese)](./README_CHS.md), Tiếng Việt (Vietnamese)
Bản vá nhân macOS gần như native dành cho CPU AMD.

### Đặc trưng:
- Giúp macOS có thể chạy trực tiếp và trơn tru trên chip AMD.
- Dùng được iMessage, Siri, FaceTime, Continuity, vân vân.
- Ổn định hơn nhân XNU tự điều chế.

### Nhược điểm:
- Không hỗ trợ 32bit (OPEMU) Từ phiên bản 10.14 trở xuống

### CPU AMD được hỗ trợ:
| Mã đời | Tên đời | Ví dụ |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | Sê-ri A (bao gồm AM4 A Sê-ri) |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h) | Zen | Ryzen, Threadripper thế hệ 1, 2 hoặc 3, Athlon 2xxGE |<br />

### Lưu ý với các máy dùng chipset TRX40:
Tắt `mtrr_update_action - fix PAT` có thể làm tăng hiệu năng GPU trên một số máy. Nếu bạn muôn thử, hãy thử bằng OpenCore trên một USB rời trước. Có thể có một vài vấn đề với combo mainboard/GPU mà chúng tôi không thể lường trước được. Chúng tôi không chiu trách nhiệm trước bất cứ hỏng hóc nào.

### Phiên bản macOS được hỗ trợ
- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x

### Hướng dẫn
- Tải macOS High Sierra, Mojave hoặc Catalina tử App Store.
- Cắm một USB trống vào máy.
- Chạy một trong số các lệnh sau để tạo USB cài.
```
Lưu ý: Thay 'MyVolumeName' bằng volume của USB trên máy.

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- Cài OpenCore vào USB. (Lấy các bản release OpenCore ở đây: https://github.com/acidanthera/OpenCorePkg/releases)
- Đọc [Tài liệu về OpenCore](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) để sửa file `config.plist`. Có file config mẫu có sẵn trong bộ cài.
- Cài đặt bản vá vào file config `config.plist`, tuỳ vào đời CPU (i.e `15h_16h` or `17h`) để chọn vàn vá phù hợp và sửa file config tuỳ mong muốn của bạn.

### Lưu ý đặc biệt:
- Các bản vá này yêu cầu OpenCore 0.6.1 trở lên.
- Để được hỗ trợ tạo file `config.plist`, vào [trang này](https://dortania.github.io/OpenCore-Install-Guide/) hoặc vào Discord server.
- Với CPU đời 15h_16h muốn cai macOS Mojave:
  - Lúc bôt vào macOS Mojave làn đầu, máy sẽ bị khởi động lại ngay sau màn hình Data & Privacy (Dữ Liệu & Quyển Riêng Tư). Để khăc phuc vui lòng làm theo [hướng dẫn này](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085), ở mục UPDATE-2.
  - Một vài trang web nhất định trên macOS Mojave sẽ lỗi khi tải (vd. brew.sh, facebook.com). Để khăc phuc vui lòng làm theo [hướng dẫn này](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857), ơ mục UPDATE-5.
- Để khởi động macOS 10.15, có hai điêu cần lưu ý:
  - Nếu máy bạn có thiết bị EC (Embedded Controller) với ID `PNP0C09` (thấy trong DSDT), nó có thể sẽ khiến macOS không thể khởi động được. Để sửa ban cân phải phải tắt thiết bị EC nay đi bằng cách trả về `Không`. Ban có the sử dụng [SSDT-EC0.aml](./Extra/SSDT-EC0.aml) để làm việc đó. Nếu ban muốn xem cách nó hoạt động, vui lòng vào [trang này](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33). <br> -hoặc- <br> Bạn có thể thay đổi ID của thiết bị EC bằng cach sử dụng ACPI patch này:
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - Khi sử dụng các SMBIOS `MacPro6,1`, `MacPro7,1`, hoặc `iMacPro1,1`, `AppleIntelMCEReporter.kext` macOS có thể gây lỗi. Để khăc phục bạn có thể dùng SMBIOS khác hoặc tắt kext đó [ở đây](../Extra/AppleMCEReporterDisabler.kext.zip).

### Người đóng góp:
- [AlGrey](https://github.com/AlGreyy) về ý tưởng và bản vá.
- [XLNC](https://github.com/XLNCs) vì đã/đang bảo trì bản vá cho nhiều bản macOS khác nhau.
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee và rất nhiều người khác đã chia sẻ kiến thức bản thân về AMD/XNU
- [0xD81CF](https://github.com/0xD81CF), [doesprintfwork](https://github.com/doesprintfwork) và [erikjara](https://github.com/erikjara) cho việc dịch readme.
