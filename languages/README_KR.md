<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### Languages: [English](../README.md), [Ukrainian](languages/README_UA.md), [Russian](languages/README_RUS.md), [Traditional Chinese](languages/README_CHT.md), [Spanish](languages/README_ES.md), [Simplified Chinese](languages/README_CHS.md), [Vietnamese](languages/README_VI.md), Korean (현재)
macOS에서 AMD CPU를 지원하기 위한 커널 바이너리 패치입니다.

### 기능
- macOS를 AMD CPU에서 바로 실행 가능하게끔 해줍니다.
- 아이메세지, 시리, 페이스타임, 애플 연속성 기능 등을 사용할 수 있게 해줍니다.
- 수정된 XNU 커널보다 안정적입니다.

### 단점
- 10.14 나 더 낮은 버전에서는 32 비트가 지원되지 않습니다 (OPEMU).

### 지원되는 AMD CPU's
| 패밀리 | 코드네임 | 예시 |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | 불도저 | FX 시리즈|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | 재규어 | A 시리즈 (AM4 A 시리즈 포함) |
|   [17h and 19h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h_19h) | 젠 | 라이젠, 1, 2 + 3세대 쓰레드리퍼, 애슬론 2xxGE |<br />

### PAT fix 패치 정보
기본값으로 Algrey의 원래 패치가 활성화되어 있습니다. 이 패치는 모든 GPU에서 작동하며, 오디오에 영향을 주지 않지만 성능은 개선되지 않습니다.
다른 선택지는 Shaneee 패치입니다. 이 패치는 AMD GPU 성능을 향상시켜주지만 Nvidia GPU에서 부팅하지 않을 수 있습니다. 그리고 HDMI와 DP 오디오에서 문제를 일으킬 수 있습니다.
어떤 패치를 사용할지는 사용자의 선택입니다. 두 패치를 동시에 사용하지 마세요.

### TRX40 시스템에서 주의 사항
몇몇 시스템에서 `mtrr_update_action - fix PAT` 패치를 비활성화하면 GPU 성능이 향상되는 것을 확인했습니다. 테스트하고 싶으시다면, 수정 사항이 확실히 작동하는 것을 확인하기 위해 먼저 USB에 오픈코어를 설치해서 테스트해보는 것을 권장합니다. 저희가 알 수 없는 다른 메인보드/GPU 조합에서는 문제가 생길 수도 있습니다. 모든 것은 사용자 책임입니다.

### 지원되는 macOS 버전
- 하이 시에라 10.13.x
- 모하비 10.14.x
- 카탈리나 10.15.x
- 빅서 11.x

### 설치 방법
- macOS 하이 시에라, 모하비 또는 카탈리나를 앱 스토어에서 다운로드합니다.
- 비어있는 USB 드라이브를 연결합니다.
- 부팅 가능한 macOS USB를 준비하기 위해 터미널에 아래 명령어 중 하나를 입력하세요.
```
주의: 아래 명령어들의 'MyVolumeName'을 연결된 USB의 진짜 볼륨 이름으로 바꿔야 합니다.

## 하이 시에라
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## 모하비
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## 카탈리나
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## 빅서
sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- 오픈코어를 USB 드라이브에 설치합니다. (배포된 오픈코어들은 여기서 확인하세요: https://github.com/acidanthera/OpenCorePkg/releases)
- `config.plist`를 설정하기 위해 [오픈코어 문서](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf)를 읽어보세요. 기본 설정값은 제공되지 않을 것입니다.
- 사용 중인 CPU 종류 (`15h_16h` 또는 `17h`) 에 따라 여기서 제공되는 패치를 오픈코어 `config.plist` 파일에 합칩니다. 그리고 필요에 따라 수정하세요.

### 읽어보세요
- 이 패치들은 오픈코어 0.6.1 이나 그 이상의 버전에서 작동합니다.
- 오픈코어 설정 파일을 만들 때 지원을 받기 위해선 제공되는 문서 파일을 읽고 [이 가이드](https://dortania.github.io/OpenCore-Install-Guide/)를 보거나 디스코드 서버에 들어오세요.
- macOS 모하비를 사용하는 15h_16h CPU 사용자들에게:
  - macOS 모하비를 처음 부팅할 때, 데이터 & 개인 정보 보호 화면 이후 재부팅될 것입니다. 이 오류를 해결하려면 [여기](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085)의 Update-2 머릿말 아래의 내용대로 따라하세요.
  - macOS 모하비에서 몇몇 웹페이지가 로딩 중 충돌이 일어날 수 있습니다 (brew.sh, facebook.com 등). 이 오류를 해결하려면 [여기](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857)의 Update-5 머릿말 아래의 내용대로 따라하세요.
- 10.15를 부팅하기 위해 2가지 주의해야할 점이 있습니다:
  - DSDT에 ID가 `PNP0C09`인 EC 디바이스가 있다면 macOS의 초기 부팅 단계에서 멈출 수도 있습니다. 해결하기 위해 `Zero`를 반환하도록 만들어서 EC 디바이스가 비활성화 되어 있는지 확인하세요. 대신 수정된 [SSDT-EC0.aml](../Extra/SSDT-EC0.aml)을 사용할 수도 있습니다. 어떻게 작동되는 건지 보고 싶으시다면 [여기](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33)를 참고하세요. <br> -또는- <br> EC 디바이스의 ID를 바꾸는 방법도 있습니다. 이 ACPI 패치를 사용하세요:
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - `MacPro6,1`, `MacPro7,1`, 또는 `iMacPro1,1` SMBIOS를 사용하거나 `AppleIntelMCEReporter.kext` 를 사용하면 macOS에서 패닉이 일어날 수도 있습니다. 패닉을 방지하기 위해선 다른 SMBIOS를 사용하거나 [여기](../Extra/)의 비활성화 kext를 사용하세요.

### 크레딧
- [AlGrey](https://github.com/AlGreyy): 아이디어 제공과 패치를 만듦
- [XLNC](https://github.com/XLNCs): 다양한 macOS 버전을 지원하기 위해 패치를 유지보수함
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee 와 다른 많은 분들: AMD/XNU 커널 정보를 공유함
- [0xD81CF](https://github.com/0xD81CF), [doesprintfwork](https://github.com/doesprintfwork) 와 [erikjara](https://github.com/erikjara): README를 번역함
