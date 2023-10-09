# Twinkle Twinkle Energy Star

![Award Modular BIOS v4.51PG]
![Award Modular BIOS v6.00PG]

> _See? It's a happy BIOS after all!_

### Objective

Replace the [ENERGY STAR] logo on the POST screen with a custom image of your
choosing.

### Overview

The ENERGY STAR logo signifies that a product complies with the energy
efficiency standards established by the ENERGY STAR program, managed by the
United States Environmental Protection Agency (EPA). This symbol is notable for
its appearance on the Power-On Self-Test (POST) screen of older BIOS, making it
familiar to those who remember using a PC in the 1990s and early 2000s.

Within the context of the Award Modular BIOS, the ENERGY STAR logo on the POST
screen is often referred to as the “EPA logo”. It is stored in the BIOS in a
unique image format known as the Award BIOS Logo, AWBM, or EPA. Two versions of
this format, typically known as versions 1 and 2, are detailed on the
[File Formats] wiki.

Software tools exist to both display and create Award BIOS Logo files, usually
by converting from another image format like BMP. A valid Award BIOS Logo file
can be incorporated into an Award Modular BIOS ROM image using [CBROM], which
includes an `/epa` command line option.

```
/epa|epa1-7 : Add EPA LOGO BitMap to System BIOS
```

### Hints

No specific guidance is provided for this challenge.

### Solution

> Work in progress.

<!-- External links -->
[File Formats]: http://fileformats.archiveteam.org/wiki/Award_BIOS_logo
[CBROM]: https://archive.org/details/cbrom
[ENERGY STAR]: https://energystar.gov

<!-- Included assets -->
[Award Modular BIOS v4.51PG]: ../../../assets/badges/award_4-51PG.svg
[Award Modular BIOS v6.00PG]: ../../../assets/badges/award_6-00PG.svg