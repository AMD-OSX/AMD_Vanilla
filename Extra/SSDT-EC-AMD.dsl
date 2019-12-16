/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20191018 (64-bit version)
 * Copyright (c) 2000 - 2019 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLuLTesq.aml, Sun Dec 15 22:48:56 2019
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000006E (110)
 *     Revision         0x02
 *     Checksum         0x74
 *     OEM ID           "ACDT"
 *     OEM Table ID     "EC0"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20180427 (538444839)
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "EC0", 0x00001000)
{
    External (_SB_.PCI0.SBRG.EC0_, DeviceObj)

    Scope (\_SB.PCI0.SBRG.EC0)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (0x0F)
            }
        }
    }
}

