<span align="center">

<h1>AMD Vanilla Clover</h1>

</span>


### Non c'e' nessun supporto per sistemi operativi beta. <br /><br />Provate le patches a vostro rischio e pericolo, fate un backup prima della vostra EFI funzionante.  

### Lingue: [English](README.md), Italian (Attuale)

Patches per il Kernel che abilitano il supporto nativo di CPU AMD su macOS.
  
# Leggere con attenzione!



Le patch sono ora universali per le piattaforme 15h, 16h, 17h e 19h.

### Non usate l'applicazione Clover Configurator. Potrebbe rimuovere parti importanti del vostro config nella sezione Kernel Patches!
### L'opzione Resize Bar nei bios (C.A.M in alcuni bios x299) e' ora supportata a partire dal commit b624e4d1e del master di Clover. 

La patch Core Count necessita di essere modificata per il tuo sistema. Cerca le tre patch `algrey - Force cpuid_cores_per_package`e modifica solo il valore di Replace.

da cambiare `B8000000 0000`/`BA000000 0000`/`BA000000 0090`* _con_ `_B8_ <CoreCount> _0000 0000_`_/_`_BA_ <CoreCount> _0000 0000_`_/_`_BA_ <CoreCount> _0000 0090`* sostituendo `<CoreCount>` Con il valore esadecimale corrispondente al tuo numero di core.

****Nota:**** *_Ogni patch e' da modificare a seconda di macOS utilizzato. Assicurati di cambiare tutti e tre i valori se usi OSx da macOS High Sierra a Monterey_*

Verifica i valori dalla tabella qui sotto in base al numero di core della tua CPU.

| CoreCount | Esadecimale|
|--------|---------|
|   4 Core  | `04` |
|   6 Core  | `06` |
|   8 Core  | `08` |
|   12 Core | `0C` |
|   16 Core | `10` |
|   24 Core | `18` |
|   32 Core | `20` |

  
Quindi, per una CPU con 6 core come il 5600X, sostituire i valori come in questo esempio `B8 06 0000 0000`/`BA 06 0000 0000`/`BA 06 0000 0090`

#### Alcuni utenti potrebbero avere la necessità di utilizzare la patch `algrey - cpu_topology_sort -disable _x86_validate_topology`. Se necessaria, abilitarla nel config

___


### Caratteristiche
- Abilita la possibilità di usare CPU AMD al volo su macOS.
- Abilita iMessage, Siri, FaceTime, Continuity etc.
- Stabile se comparato al custom XNU kernel.

### Svantaggi
- Non c'è supporto per il  32-bit (OPEMU) per  10.14 e precedenti


### AMD CPU supportate
| Famiglia | Nome in Codice| Esempio|
|----------|---------------|---------|
| 15h      |    Bulldozer  |FX Series|
| 16h      | Jaguar | A Series (including AM4 A-Series) |
| 17h and 19h | Zen | Ryzen, 1st, 2nd + 3rd Gen Threadripper, Athlon 2xxGE |<br />

## Informazioni sulla patch PAT fix
Di base è abilitata la patch originale di Algrey. Questa patch funziona per tutte le GPU e non crea problemi all'audio, non aumenterà le prestazioni della GPU.
Altra possibilità è la patch di Shaneee che darà un notevole miglioramento prestazionale, ma potrebbe causare dei problemi all'audio (HDMI,DP).

## Nota per i sistemi TRX40
Questa patch non e' necessaria per ogni sistema TRX40 testato (Asus, AsRock,Msi, Gigabyte etc.)

### Versioni di macOS supportate
- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x
- Big Sur 11.x
- Monterey 12.x

### Istruzioni
- Scarica macOS High Sierra, Mojave, Catalina, Big Sur o Monterey dall' App Store.

- Inserisci una chiavetta USB vuota.

- Esegui i comandi di seguito da terminale per preparare una chiavetta USB autopartente

```
NOTA: Assicurati di cambiare 'MyVolumeName' con il nome attuale del volume USB che stai usando nei comandi di seguito mostrati.

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Big Sur
sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Monterey
sudo /Applications/Install\ macOS\ Monterey.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

Prova queste patch a tuo unico rischio e pericolo (fai una copia della tuEfi funzionante prima)

Lingue: Inglese ed Italiano (al momento)
```
- Installa Clover sulla tua periferica USB

- Unisci la sezione KernelPatch di `patches.plist` nel tuo `config.plist` nella cartella Clover della tu EFi `EFI/EFI/CLOVER/` e modificala secondo le tue necessità.

### Note speciali
- Per le famiglie di CPU  15h_16h CPU su macOS Mojave:
- Prima di partire con macOS Moyave, il sistema ripartirà dopo la schermata Data & Privacy. Per sistemare questo problema segui  [qui](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) voce UPDATE-2.

- Su macOS Mojave certe pagine web daranno errore (es. brew.sh, facebook.com). Per sistemare questo problema segui la procedura [qui](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) voce UPDATE-5.

- Per far partire macOS  10.15 devi prenderti cura di due cose:

- Se hai una periferica EC con ID `PNP0C09` nel tuo DSDT macOs potrebbe inchiodarsi nelle fasi iniziali. Per sistemare questo problema, devi assicurarti che la tua periferica sia disabilitata e che abbia il suo stato impostato su 'Zero'. Puoi usare un apposito [SSDT-EC0.aml](./Extra/SSDT-EC0.aml) per fare questo e se vuoi vedere come funziona fai riferimento [qui](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33). <br> -or- <br> Puoi cambiare l' ID della periferica EC. Usa questa patch ACPI:

```
Comment Find  Replace
PNP0C09 to PNPFFFF  41D00C09 41D0FFFF
```
- Se usi SMBIOS `MacPro6,1`, `MacPro7,1`, or `iMacPro1,1`, `AppleIntelMCEReporter.kext` potrebbe andare in KP. Per prevenire questo problema devi usare un differente SMBios o utillizzare un kext per inibire l'errore [qui](./Extra/).


### Crediti

- [AlGrey](https://github.com/AlGreyy) per l'idea e la creazione delle patch.

- [XLNC](https://github.com/XLNCs) per aggiornare e mantere le patch per varie versioni macOS.

- [macOS86.it](https://www.macos86.it) team per aggiornare le patch per il bootloader Clover. [fabiosun](https://www.macos86.it/profile/13-fabiosun), [iGPU](https://www.macos86.it/profile/1303-igpu), [carlo67](https://www.macos86.it/profile/17-carlo_67) and [Tomnic](https://www.macos86.it/profile/69-tomnic)

- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, [Shaneee](https://github.com/Shaneee) e molti altri per la condivisione della loro conoscenza sul kernel AMD/XNU
