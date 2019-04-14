
# AMD Vanilla Clover Patches

## Patches to enable Native AMD CPU Support on 10.13.6 and 10.14.x

 -  Supports Zen CPUs  (Ryzen, Threadripper, Athlon 2xxGE) 
 -  Beta 15H (Bulldozer) and 16H (Jaguar) CPUs Support (FX, A Series...)
 -  Enables iMessage, Siri, Facetime, etc.
 -  No OPEMU (32-bit app support)
 
 
 Zen Supported macOS : 
 - High Sierra 10.13.6 (17G65, 17G66, 17G5019, 17G6029, 17G6030)
 - Mojave 10.14.1, 10.14.3, 10.14.4
 
 15H/and 16H Supported macOS:
 - High Sierra 10.13.6 (17G65 , 17G66, 17G6029 , 17G6030)
 - Mojave 10.14.4
 
 ## How to use
 Add the patches from the [patches.plist](https://github.com/AMD-OSX/AMD_Vanilla/blob/master/15h:16h%20FX/patches.plist) in [the FX folder](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/15h:16h%20FX) or the [patches.plist](https://github.com/AMD-OSX/AMD_Vanilla/blob/master/Zen/patches.plist) in [the Zen folder](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/Zen) to your config.plist. If you have existing patches you may want to merge them.
 
 #### OR
 
 Replace your current config.plist with the [config.plist](https://github.com/AMD-OSX/AMD_Vanilla/blob/master/15h:16h%20FX/config.plist) in [the FX folder](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/15h:16h%20FX) or the [config.plist](https://github.com/AMD-OSX/AMD_Vanilla/blob/master/Zen/config.plist) in [the Zen folder](https://github.com/AMD-OSX/AMD_Vanilla/tree/master/Zen). Make any changes as necessary.
 
 ### Credits to [AlGrey](https://github.com/AlGreyy)

 #### [XLNC](https://github.com/XLNCs) for testing on FX and for porting the 15H/16H patches to 10.13.6 (17G65 , 17G66) and 10.14.4
