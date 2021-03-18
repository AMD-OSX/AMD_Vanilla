<span align="center">
<h1>AMD Vanilla OpenCore</h1>
</span>

### Diller (Languages): [English](../README.md), [Ukrainian](./README_UA.md), [Russian](./README_RUS.md), [Traditional Chinese](./README_CHT.md), [Spanish](./README_ES.md), [Simplified Chinese](./README_CHS.md), [Vietnamese](./README_VI.md), Türkçe (mevcut)
MacOS'da neredeyse native olarak AMD işlemci desteğini kazandıran binary kernel yamaları.

### Özellikler
- macOS'da AMD işlemcileri anında çalıştırmayı etkinleştirir.
- iMessage, Siri, Facetime, Süreklilik vb araçları etkinleştirir.
- Özel XNU çekirdeğine kıyasla kararlı.

### Dezavantajları
- 10.14 sürümü ve altında 32 bit desteği (OPEMU) mevcut değildir.

### Desteklenen AMD İşlemciler
| İşlemci Ailesi | İşlemci Kod Adı | Örnek |
|--------|---------|----------|
|   [15h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Bulldozer | FX Series|
|   [16h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/15h_16h)  | Jaguar | A Series (AM4 A-Series de içermekte) |
|   [17h ve 19h](https://github.com/AMD-OSX/AMD_Vanilla/tree/opencore/17h_19h) | Zen | Ryzen, 1st, 2nd + 3rd Gen Threadripper, Athlon 2xxGE |<br />

### PAT Düzeltme Yamasına İlişkin Bilgiler
Varsayılan olarak etkin olan yama AlGrey'in orijinal yamasıdır. Bu bütün GPUlar için çalışacak fakat sesi etkilemeyecektir. Ancak performansı da arttırmayacaktır.
Diğer bir seçim olarak Shaneee'nin yaması AMD GPUlar için GPU performansını arttırır ama Nvidia GPUların boot etmesini durdurur. Bu yama ayrıca HDMI ve DP üzerinden ses sorununa yol açacaktır.
Hangi yamayı kullanacağınız konusunda seçim sizindir. Lütfen ikisini aynı anda kullanmayı denemeyin.

### TRX40 Sistemleri Hakkında Not
`mtrr_update_action - fix PAT` yamasının devre dışı bırakılması test edilen bazı sistemlerde GPU performansında gelişme olduğunu göstermiştir. Bunu test etmek isterseniz ilk olarak çalıştığından emin olmak için OpenCore kurulumlu bir USB üzerinde yapmanız önerilir. Farkında olmadığımız farklı Anakart/GPU kombinasyonlarıyla alakalı sorunlar çıkabilir. Sorumluluk size aittir.

### Destekli macOS sürümleri
- High Sierra 10.13.x
- Mojave 10.14.x
- Catalina 10.15.x
- Big Sur 11.x

### Kurulum Talimatları
- MacOS High Sierra, Mojave veya Catalina'yı App Store'dan indirin.
- Boş bir USB sürücüsü takın.
- Önyüklenebilir macOS USB'yi hazırlamak için Terminalde aşağıdaki komutlardan kurulum için gereken uygun sürüme olanı çalıştırın.
```
NOT: Aşağıdaki komutlarda 'MyVolumeName' yazan tırnak içindeki kısmı USB diskinizin gerçek birim (volume) adıyla değiştirdiğinizden emin olun.

## High Sierra
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Mojave
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName

## Big Sur
sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolumeName
```
- OpenCore'u USB diskinize yükleyin. (OpenCore sürümleri için bkz.: https://github.com/acidanthera/OpenCorePkg/releases)
- `config.plist` hazırlamak için [OpenCore Belgelerini](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf) okuyun. Varsayılan bir yapılandırma (config) dosyası burada sağlanmayacaktır.
- Sağlanan yamaları CPU ailenize göre (yani `15h_16h` veya `17h` gibi) OpenCore `config.plist`'e birleştirin ve ihtiyaçlarınıza göre düzenleyin.

### Özel Notlar
- Bu yamalar OpenCore 0.6.1 sürümü ve üstünü gerektirir.
- OpenCore yapılandırması (config) oluşturmak için belgeleri okuyun ve [buradaki](https://dortania.github.io/OpenCore-Install-Guide/) rehberi veya Discord sunucusunu ziyaret edin.
- macOS Mojave'de bulunan 15h_16h CPU ailesi kullanıcıları için:
  - MacOS Mojave ilk kez boot edildiğinde, Sisteminiz Veri ve Gizlilik ekranından sonra yeniden başlatacaktır. Bu sorunu çözmek için [burada](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2658085) belirtilen UPDATE-2 başlığı altındaki prosedürü izleyin.
  - MacOS Mojave'de belirli web sayfaları yüklenirken kilitlenir (Örn. Brew.sh, facebook.com). Bu sorunu çözmek için [burada](https://www.insanelymac.com/forum/topic/335877-amd-mojave-kernel-development-and-testing/?do=findComment&comment=2661857) belirtilen UPDATE-5 başlığı altındaki prosedürü izleyin.
- 10.15'i boot etmek için iki şeye dikkat edilmesi gerekir:
  - `PNP0C09` ID numaralı EC device, DSDT dosyanızda mevcutsa macOS ilk aşamada boot sırasında takılabilir. Bunu çözmek için EC device'ı `Zero` durumuna döndürerek devre dışı bırakın. Özelleştirilmiş (custom) bir [SSDT-EC0.aml](./Extra/SSDT-EC0.aml) dosyasını kullanarak bunu yapabilirsiniz. Nasıl çalıştığını görmek istiyorsanız [buraya](https://github.com/acidanthera/OpenCorePkg/blob/5e020bb06b33f12fa8b404cc3d1effaa5fbc00ea/Docs/AcpiSamples/SSDT-EC.dsl#L33) başvurabilirsiniz. <br> -veya- <br> EC Device'ın kimliğini değiştirebilirsiniz. Bunun için ACPI yamasını uygulayın:
    ```
        Comment             Find        Replace
    PNP0C09 to PNPFFFF    41D00C09     41D0FFFF
    ```
  - `MacPro6,1`, `MacPro7,1`, or `iMacPro1,1`, `AppleIntelMCEReporter.kext` SMBIOSlarını kullanırken macOS kernel panic oluşturabilir. Bunu önlemek için ya farklı bir SMBIOS kullanmanız ya da [burada](./Extra/) bu durumu devre dışı bırakacak kext'i kullanmanız gerekir.

### Emeği Geçenler
- [AlGrey](https://github.com/AlGreyy) proje fikrine sahip ve yamaları oluşturdu.
- [XLNC](https://github.com/XLNCs) çeşitli macOS sürümlerine yönelik yamaları devam ettirdi.
- Sinetek, Andy Vandijck, spakk, Bronya, Tora Chi Yo, Shaneee ve diğer birçok kişi kendilerinin AMD / XNU çekirdek bilgilerini paylaştı.
- [0xD81CF](https://github.com/0xD81CF), [doesprintfwork](https://github.com/doesprintfwork) ve [erikjara](https://github.com/erikjara) readme dosyası çevirilerini hazırladı.
