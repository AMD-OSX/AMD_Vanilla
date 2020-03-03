<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### Доступные языки (Languages): [English](../README.md), Russian (текущий), [Traditional Chinese](./README_CHT)
Бинарные патчи ядра для включения практически нативной поддержки процессоров от AMD в macOS.

### Особенности
- Позволяют macOS стабильно работать на процессорах от AMD.
- Поддерживают iMessage, Siri, FaceTime, Continuity и т.д.
- Стабильнее кастомного ядра XNU.

### Недостатки
- Нет поддержки 32-битных приложений (OPEMU) в версии 10.14 и ниже.

### Поддерживаемые процессоры
| Поколение | Микроархитектура | Семейство |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A Series (включая AM4 A-Series) |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h) | Zen | Ryzen, Threadripper, Athlon 2xxGE | <br />

### Поддерживаемые версии macOS
- High Sierra 10.13.*
- Mojave 10.14.*
- Catalina 10.15.*

### Инструкция
- Загрузите macOS High Sierra, Mojave или Catalina из App Store.
- Подключите пустой USB-накопитель.
- Запустите одну из следующих команд для создания загрузочного носителя.
```
ВАЖНО: Не забудьте заменить 'MyVolumeName' на название необходимого USB раздела.

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- Установите OpenCore на EFI раздел накопителя (Релизы OpenCore доступны здесь: https://github.com/acidanthera/OpenCorePkg/releases)
- Ознакомьтесь с [документацией OpenCore](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) для создания `config.plist`. Стандартная конфигурация не предоставлена (Вы должны создать её сами)
- Добавьте в свой `config.plist` патчи, которые соответствуют поколению Вашего процессора (`15_16h` или `17h`). Отредактируйте их, если это необходимо.

### Специальные заметки
- Данные патчи требуют OpenCore версии 0.5.2 и выше. Они не будут работать на версии 0.5.1 и ниже.
- Для получения дополнительных сведений по созданию конфига OpenCore ознакомьтесь с документацией и посетите [данный](https://khronokernel-2.gitbook.io/opencore-vanilla-desktop-guide/) гайд, а также наш сервер в Discord.
- Для пользователей **macOS Mojave c процессорами 15 и 16 поколения**:
  - В процессе первого запуска система  будет перезагружаться после этапа `Данные и конфиденциальность`. Для решения данной проблемы следуйте [данной](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) инструкции (она находится под заголовком `UPDATE-2`).
  - В браузерах некоторые веб-страницы могут не загружаться или вызывать зависание системы во время загрузки (brew.sh, facebook.com и т.д). Для решения этой проблемы следуйте [данной](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) инструкции (она находится под заголовком `UPDATE-5`)
- Для использования macOS Catalina необходимо обратить внимание на два пункта
   - Если в Вашем DSDT присутствует устройство **EC** с ID `PNP0C09`, то macOS может остановиться на начальном этапе загрузки системы. Для решения этой проблемы Вы должны удостовериться в том, что Ваше **EC** устройство выключено при помощи возвращаемого значения `Zero`. Для этого Вы можете использовать кастомный [SSDT-EC0.aml](./Extra/SSDT-EC0.aml). Если Вы хотите разобраться в этом подробнее - посетите [данную](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33) страницу.
    <br> -или- <br> Вы можете изменить ID у **EC** устройства путём использования данного ACPI патча:
      ```
          Comment             Find        Replace
      PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
      ```
  - Если Вы используете один из этих SMBIOS: `MacPro6,1`, `MacPro7,1`, `iMacPro1,1` -- `AppleIntelMCEReporter.kext` может вызвать панику ядра. Для решения этой проблемы Вы можете выбрать другой SMBIOS или добавить в свой загрузчик [данное расширение ядра (kext)](./Extra).

### Благодарности
- [AlGrey](https://github.com/AlGreyy) за идею и создание патчей.
- [XLNC](https://github.com/XLNCs) за поддержание актуальности патчей к различным версиям macOS и поколениям процессоров.
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee и многих других за то, что они поделелились своими идеями и знаниями в области XNU & AMD.
- [0xD81CF](https://github.com/0xD81CF) и [doesprintfwork](https://github.com/doesprintfworok) за перевод и адаптацию README.
