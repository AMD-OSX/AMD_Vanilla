<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### Sprachen: English (../README.md), [Ukrainian](languages/README_UA.md), [Russian](languages/README_RUS.md), [Traditional Chinese](languages/README_CHT.md), [Spanish](languages/README_ES.md), [Simplified Chinese](languages/README_CHS.md), [Vietnamese](languages/README_VI.md), [German](ausgewählt)
Kernel Binärpatches zur Aktivierung von fast nativer AMD-CPU-Unterstützung unter macOS.

### Features
- Ermöglicht es macOS "on the fly" auf AMD CPUs zu laufen.
- Aktiviert iMessage, Siri, FaceTime, Continuity etc.
- Im Vergleich zu custom XNU Kerneln stabil.

### Nachteile
- Kein 32-bit Unterstützung (OPEMU) in 10.14 und älter

### Unterstützte AMD CPUs
| Familie | Codename| Beispiele |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A Series (inklusive AM4 A-Serie) |
|   [17h and 19h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h_19h) | Zen | Ryzen, 1st, 2nd + 3rd Gen Threadripper, Athlon 2xxGE |<br />

### Information zum PAT fix patch
Der standardmäßig aktivierte Patch ist Algreys originaler Patch. Dieser funktioniert mit allen GPUs und beeinträchtigt nicht den Ton, aber erhöht auch nicht die Leistung.
Die andere Wahl ist Shaneees Patch, welcher die GPU Performance von AMD GPUs verbessern kann, aber Nvidia GPUs vom Booten abhalten kann. Außerdem kann es Tonprobleme bei der Nutzung von HDMI und DisplayPort Audio verursachen.
Es ist deine Wahl, welchen Patch du nutzt. Du kannst allerdings nur einen auf einmal verwenden.

### Notiz zu TRX40 Systemen
Disabling the `mtrr_update_action - fix PAT` patch has shown an improvement in GPU performance on some systems that have tested. If you wish to test this it is recommended to do so on a USB with OpenCore to ensure it works first. 
Die Deaktivierung des `mtrr_update_action - fix PAT` Patches hat auf manchen getesteten Systemen eine Verbesserung der GPU Performance erreicht. Wenn du das testen möchtest, empfiehlt es sich, einen USB-Stick mit OpenCore zu nutzen, um die korrekte Funktionsweise ohne Risiko zu prüfen.

### Unterstütze macOS Versionen
- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x

### Anleitung
- Download macOS High Sierra, Mojave or Catalina from the App Store.
- Lade macOS High Sierra, Mojave oder Cataline vom App Store herunter.
- Schließe einen leeren USB-Stick an.
- Führe einen der folgenden Befehle im Terminal aus, um einen bootbaren macOS USB-Stick vorzubereiten.
```
ACHTUNG: Stelle sicher, dass du in den folgenden Befehlen 'MyVolumeName' mit dem tatsächlichen Namen deines USB-Sticks ersetzt.

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Big Sur
sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- Installiere OpenCore auf deinem USB-Stick. (Hier kannst du Releases von OpenCore beziehen: https://github.com/acidanthera/OpenCorePkg/releases)
- Lese die [OpenCore Dokumentation](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) für die Erstellung der `config.plist`. Eine Standardkonfiguration wird nicht bereitgestellt.
- Füge die bereitgestellten Patches passend zu deiner CPU-Familie (z.B: `15h_16h` oder `17h`) in deiner OpenCore `config.plist` ein und bearbeite sie nach deinen Bedürfnissen.

### Besondere Hinweise
- Diese Patches benötigen OpenCore 0.6.1 und höher.
- Lese die Dokumentation, besuche [diesen](https://dortania.github.io/OpenCore-Install-Guide/) Guide oder den Discord Server, um Hilfe bei der Erstellung der OpenCore Konfiguration zu erhalten.
- Für Nutzer von CPU-Familie 15h_16h unter macOS Mojave:
  - Nachdem du macOS Mojave zum ersten Mal gestartet hast wird das System nachdem "Daten & Datenschutz"-Bildschirm neu starten. Dieses Problem kann mit der [hier](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) unter der "UPDATE-2"-Unterschrift besprochenen Methode behoben werden.
  - Unter macOS Mojave werden manche Webseiten nach dem Laden abstürzen (z.B. brew.sh oder facebook.com). Dieses Problem kann mit der [hier](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) unter der "UPDATE-5"-Unterschrift besprochenen Methode behoben werden.
- Um 10.15 starten zu können, müssen zwei Dinge beachtet werden:
  - Wenn du ein EC-Gerät mit der ID `PNP0C09` in deiner DSDT hast, kann macOS in der initialen Phase des Startens einfrieren. Das Problem kann behoben werden, indem du das EC-Gerät durch das Setzen des Rückgabestatus `Zero`deaktivierst. Du kannst eine custom [SSDT-EC0.aml](./Extra/SSDT-EC0.aml) nutzen um das zu machen und wenn du wissen möchtest, wie das funktioniert, kannst du [hier](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33) nachgucken. <br> -oder- <br> Du änderst die ID deines EC-Geräts durch die Nutzung dieses Patches:
    ```
        Kommentar             Finde        Ersetze durch
    PNP0C09 bis PNPFFFF    41D00C09     41D0FFFF
    ```
  - Wenn du die SMBIOSse `MacPro6,1`, `MacPro7,1`, oder `iMacPro1,1` nutzt kann der `AppleIntelMCEReporter.kext` macOS zum Abstürzen bringen. Durch die Nutzung eines anderen SMBIOS oder einen Deaktivierungs-Kext von [hier](./Extra/) kannst du das verhindern.

### Credits
- [AlGrey](https://github.com/AlGreyy) für die Idee und die Erstellung der Patches.
- [XLNC](https://github.com/XLNCs) für die Pflege der Patches für die verschiedenen macOS Versionen.
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee und vielen anderen für das Teilen ihres AMD/XNU Kernelwissen.
- [0xD81CF](https://github.com/0xD81CF), [doesprintfwork](https://github.com/doesprintfwork) und [erikjara](https://github.com/erikjara) für ihre Readme Übersetzungen.
