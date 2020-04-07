<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### Lenguajes (Languages): [English](README.md), [Russian](languages/README_RUS.md), [Traditional Chinese](languages/README_CHT.md), Spanish (actual)
Parches binarios para el Kernel que habilitan el uso casi nativo de macOS para las CPU de AMD.

### Características principales
- Ejecutar macOS desde un procesador AMD sobre la marcha.
- Habilita el uso de iMessage, Siri, FaceTime, Continuity, etc.
- Estable en comparación a un kernel XNU personalizado.

### Desventajas
- Sin soporte para 32-bit (OPEMU) en versiones 10.14 hacia abajo.

### CPUs de AMD soportadas
| Familia | Microarquitectura | Ejemplo |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A Series (including AM4 A-Series) |
|   [17h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h) | Zen | Ryzen, Threadripper, Athlon 2xxGE | <br />

### Versiones de macOS soportadas
- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x

### Instrucciones
- Descarga macOS High Sierra, Mojave o Catalina desde la App Store.
- Inserta un dispositivo USB vacío.
- Ejecuta uno de los comandos que están abajo en la Terminal para crear un USB de arranque con macOS.
```
NOTA: Asegúrate de reemplazar 'MyVolumeName' con el nombre actual de tu dispositivo USB en los comandos de abajo.

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- Instala OpenCore en tu dispositivo USB. (Descarga OpenCore aquí: https://github.com/acidanthera/OpenCorePkg/releases)
- Lee la [Documentación de OpenCore](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) para crear tu archivo de configuración `config.plist` (No facilitamos una configuración por defecto).
- Mezcla el parche que facilitamos `patches.plist` en tu archivo de configuración de OpenCore `config.plist`. Asegura que sea acorde a tu familia de CPU (ej. `15h_16h` o `17h`) - Edítalo a tus necesidades.

### Consideraciones
- Estos parches requieren la versión 0.5.2 o superior de OpenCore. No funcionarán en versiones 0.5.1 o inferiores.
- Para obtener ayuda para crear la configuración de OpenCore, lee su documentación y revisa [esta guía](https://khronokernel-2.gitbook.io/opencore-vanilla-desktop-guide/), o únete al servidor de Discord.
- Para los usuarios de la familia de CPU 15h_16h en macOS Mojave:
  - Al arrancar macOS Mojave por primera vez, el sistema se reiniciará después de la pantalla de Datos y Privacidad. Para solucionar este problema, sigue el procedimiento mencionado [aquí](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) que está debajo del encabezado UPDATE-2.
  - En macOS Mojave, ciertas páginas web se bloquean al cargarse (ej. brew.sh, facebook.com). Para solucionar este problema, sigue el procedimiento mencionado [aquí](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) que está debajo del encabezado UPDATE-5.
- Para arrancar 10.15 se deben tener en cuenta dos cosas:
  - Si tienes un dispositivo EC con el ID `PNP0C09` en tu DSDT, probablemente macOS se estanque en su arranque inicial. Para solucionar esto debes estar seguro que tu dispositivo EC está deshabilitado haciendo que retorne el estado `Zero`. Puedes usar un [SSDT-EC0.aml](./Extra/SSDT-EC0.aml) personalizado para realizar tal cambio, y si quieres saber cómo funciona, puedes consultarlo [aquí](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33). <br> -o- <br> Puedes cambiar el ID de tu dispositivo EC usando este parche ACPI:
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - Cuando uses alguna de estas SMBIOS: `MacPro6,1`, `MacPro7,1`, o `iMacPro1,1`, el `AppleIntelMCEReporter.kext` de macOS problablemente retorne un `kernel panic`. Para evitar esto, debes usar un SMBIOS diferente o utilizar un desactivador de kexts que puedes encontrar [aquí](./Extra/).

### Créditos
- [AlGrey](https://github.com/AlGreyy) por la idea y la creación de los parches.
- [XLNC](https://github.com/XLNCs) por dar soporte a los parches en varias versiones de macOS.
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee  y muchos otros por compartir su conocimiento sobre el núcleo de AMD/XNU.
- [0xD81CF](https://github.com/0xD81CF), [doesprintfwork](https://github.com/doesprintfwork) y a [erikjara](https://github.com/erikjara) por las traducciones de README.
