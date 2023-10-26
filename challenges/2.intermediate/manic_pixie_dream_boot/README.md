# Manic PiXiE Dream Boot

![AMIBIOS 8]
![Award Modular BIOS v6.00PG]

> _Network boot after BIOS launch, expansion cards and PnP ROMs lay their_
> _function out; I fell in love with the process that day, while gazing up at_
> _the binary sky; not even an instantaneous bit of this digital sequence will_
> _fade, for I’ll embed it all into my ROM._

### Objective

Replace the [network boot ROM] embedded within a BIOS to allow your own
arbitrary code to run when selected as a boot device in the BIOS Setup Utility
screen.

### Overview

The [Preboot Execution Environment] (PXE, pronounced “pixie”) standard provides
network-server booting for computers, bypassing the need for a local disk or 
removable device. Commonly utilized for operating system installations and 
diagnostic tool executions, PXE is supported by contemporary network cards and 
system firmware, encompassing both BIOS and UEFI.

In the context of PCs operating on legacy BIOS firmware, PXE is typically 
implemented as an Option ROM. This can be sourced either from a memory chip 
located on the network card—as observed in removable PCI Express network cards
— or embedded within the BIOS itself, characteristic of integrated network
cards.

### Hints

If you require additional information to accomplish this challenge, please
refer to the [Hints] file.

### Solution

> Work in progress.

<!-- External links -->
[network boot ROM]: https://en.wikipedia.org/wiki/Option_ROM#Network_boot_ROM
[Preboot Execution Environment]: https://en.wikipedia.org/wiki/Preboot_Execution_Environment

<!-- Internal links -->
[Hints]: hints/README.md

<!-- Included assets -->
[AMIBIOS 8]: ../../../assets/badges/amibios_8.svg
[Award Modular BIOS v6.00PG]: ../../../assets/badges/award_6-00PG.svg