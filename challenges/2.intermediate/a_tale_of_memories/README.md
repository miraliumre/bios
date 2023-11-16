# A Tale Of Memories

![AMIBIOS 8]
![Award Modular BIOS v6.00PG]

> _Regardless of how valuable the data in RAM may be, once the power is off,_
> _it inevitably gets cleared. What truly matters is what you do while the PC_
> _is running, so you can power it down without any regrets._

### Objective

Perform a RAM dump during the [POST] phase.

### Overview

Gaining a precise insight into the RAM memory's layout at distinct junctures
during the BIOS code execution is not merely advantageous but often
indispensable for accomplishing certain BIOS hacking endeavors.

For this purpose, [Theldus] has created a utility named [mdump]. This tool is
coded in assembly language and is capable of being executed as bootable code.
Nonetheless, the state of the computer's memory after the BIOS execution has
completed can be substantially different than the state at the specific point
where you intend to insert your own code.

The task at hand entails injecting mdump into the BIOS framework and leveraging
it to obtain a memory dump from an early boot stage.

### Hints

If you require additional information to accomplish this challenge, please
refer to the [hints] file.

### Solution

> Work in progress.

<!-- External links -->
[mdump]: https://github.com/Theldus/AMI_BIOS_CodeInjection/tree/main/tools/mdump
[POST]: https://en.wikipedia.org/wiki/Power-on_self-test
[Davidson Francis]: https://github.com/Theldus

<!-- Internal links -->
[hints]: hints/README.md

<!-- Included assets -->
[AMIBIOS 8]: ../../../assets/badges/amibios_8.svg
[Award Modular BIOS v6.00PG]: ../../../assets/badges/award_6-00PG.svg