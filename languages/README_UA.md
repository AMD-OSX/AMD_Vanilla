<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### Мови: [English](../README.md), Ukrainian (поточна), [Russian](languages/README_RUS.md), [Traditional Chinese](languages/README_CHT.md), [Spanish](languages/README_ES.md), [Simplified Chinese](languages/README_CHS.md)
Двійкові правки до ядра macOS, які дають змогу отримати близьку до нативної підтримку процесорів AMD в операційній системі macOS.

### Можливості
- Дає змогу користуватись macOS на процесорах AMD.
- Є підтримка iMessage, Siri, FaceTime, Continuity т. ін.
- Працює стабільно у порівнянні з модифікованим ядром XNU.

### Недоліки
- Немає підтримки 32-бітних застосунків (OPEMU) в версіях macOS 10.14 та нижче.

### Процесори AMD що підтримуються
| Сім'я | Кодова назва | Приклад |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A Series (включая AM4 A-Series) |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h) | Zen | Ryzen, Threadripper, Athlon 2xxGE | <br />

### Примітка для систем на базі TRX40
На деяких TRX40 системах вимкнення правки `mtrr_update_action - fix PAT` призвело до покращення продуктивності відеокарти. Якщо ви бажаєте протестувати це, то рекомендується створити USB завантажувач з даною конфігурації радше ніж модифікувати вашу основну конфігурацію OpenCore та перевірити чи система запарцює. Можливі проблеми з деякими комбінаціями материнських плат/відеокарт про які нам невідомою. Дійте на свій страх і ризик.

### Версії macOS що підтримуються
- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x

### Вказівки
- Завантажте macOS High Sierra, Mojave чи Catalina з App Store.
- Під'єднайте пустий USB накопичувач.
- Виконайте одну з команди нижче в вашому емуляторі терміналу щоб приготувати завантажувальний диск з macOS.
```
ПРИМІТКА: Переконайтесь що ви замінили 'MyVolumeName' з назвою змонтованого тому вашого USB накопичувача при виконанні нижчевказаних команд.

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- Встановіть OpenCore на ваш USB накопичувач. (Випуски OpenCore можна знайти за наступним посиланням: https://github.com/acidanthera/OpenCorePkg/releases)
- Прочитайте [Документація OpenCore](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) щоб сконфігурувати `config.plist`. Конфігурація за замовчуванням не надається.
- Відповідно до сім вашого процесора, додайте потрібні правки з цього репозиторія (i.e `15h_16h` or `17h`) у ваш OpenCore `config.plist` та додайте інші зміни за потреби.

### Особливі примітки
- Ці правки потребують OpenCore версії 0.5.2 чи вище. Вони не працюватимуть з версією 0.5.1 чи нижче.
- Для допомоги з конфігурацією OpenCore прочитайте відповідну документацію та відвідайте [цей](https://khronokernel-2.gitbook.io/opencore-vanilla-desktop-guide/) сайт чи наш Discord сервер.
- Для користувачів процесорів 15h_16h на macOS Mojave:
  - Перед першим увімненням macOS Mojave, система перезавантажиться після етапу Дані та Конфіденційність. Щоб виправити цю проблему дотримуйтесь процедури згаданої [тут](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) під заголовком UPDATE-2.
  - В macOS Mojave при завантаженні деяких веб-сторінок (наприклад: brew.sh, facebook.com) виникатимуть помилки. Щоб виправити цю проблему дотримуйтесь процедури згаданої [тут](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) під заголовком UPDATE-5.
- Щоб успішно завантажити macOS версії 10.15 потрібно подбати про 2 речі:
  - Якщо ваш вбудований контроллер (EC) в DSDT має ідентифікатор `PNP0C09`, macOS може не завантажитись. Щоб виправити це вам потрібно переконатись що ваш EC пристрій вимкнено шляхом повернення статусу `Zero`. Для цього можна використати [SSDT-EC0.aml](../Extra/SSDT-EC0.aml), щоб це зробити та подивитись як воно працює загляніть [сюди](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33). <br> -або ж- <br> Потрібно змінити ідентифікатор вашого EC пристрою. Використавши ці правки до ACPI:
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - Якщо ви використовуєте SMBIOS `MacPro6,1`, `MacPro7,1`, чи `iMacPro1,1`, `AppleIntelMCEReporter.kext` можете викликати проблеми. Щоб цьому запобігти вам потрібно використати інший SMBIOS або ж вимикач розширення ядра що знаходиться [тут](../Extra/).

### Подяка
- [AlGrey](https://github.com/AlGreyy) за ідею та створення цих правок до ядра macOS.
- [XLNC](https://github.com/XLNCs) за підтримку правок для різних версій macOS.
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee та іншим за те що поділились своїми знаннями про AMD/XNU ядро.
- [0xD81CF](https://github.com/0xD81CF), [doesprintfwork](https://github.com/doesprintfwork), [erikjara](https://github.com/erikjara) та [hrytskivr](https://github.com/hrytskivr) за переклад README.
