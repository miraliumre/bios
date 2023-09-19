# Manic PiXiE Dream Boot

![AMIBIOS 8]
![Award Modular BIOS v6.00PG]

> _Network boot after BIOS launch, expansion cards and PnP ROMs lay their_
> _function out; I fell in love with the process that day, while gazing up at_
> _the binary sky; not even an instantaneous bit of this digital sequence will_
> _fade, for I’ll embed it all into my ROM._

### Goal

Replace the [network boot ROM] embedded within a BIOS to allow your own
arbitrary code to run when selected as a boot device in the BIOS Setup Utility
screen.

### Details

[Preboot Execution Environment] (PXE, pronounced “pixie”) is a standard to
allow computers to boot from a network server rather than from a local disk or
removable device. It is commonly used for installing operating systems and
running diagnostic tools, and implemented by most modern network cards and
system firmware (BIOS and UEFI).

For PCs based on legacy BIOS firmware, PXE is usually implemented as an Option
ROM which can either be loaded from a memory chip on the network card (as is
the case with removable PCI Express network cards) or embedded in the BIOS
itself (in the case of integrated network cards).

Those legacy network boot ROMs contain a Bootstrap Entry Vector (BEV), a
pointer which defines the code that should be executed in order to load an
operating system. The BEV is defined in a PnP Expansion header within the
Option ROM.

### Hints

> Work in progress.

### Solution

> Work in progress.

<!-- External links -->
[network boot ROM]: https://en.wikipedia.org/wiki/Option_ROM#Network_boot_ROM
[Preboot Execution Environment]: https://en.wikipedia.org/wiki/Preboot_Execution_Environment

<!-- Included assets -->
[AMIBIOS 8]: ../../../assets/badges/amibios_8.svg
[Award Modular BIOS v6.00PG]: ../../../assets/badges/award_6-00PG.svg