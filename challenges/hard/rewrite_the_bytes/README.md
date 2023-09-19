# Rewrite The Bytes

![Award Modular BIOS v6.00PG]

> _What if we rewrite the bytes? Say they were made for that board? Nothing_
> _could keep it from starting if we found the code we are meant to patch._

### Goal

Install a BIOS from one manufacturer on a motherboard that was originally
fitted with a BIOS from a different manufacturer. For example, make a version
of Award Modular BIOS function on a motherboard that was initially equiped with
AMIBIOS.

#### Conditions

Keep in mind that the goal is for you to modify the firmware yourself. Simply
replacing the pre-installed firmware with another one that already supports the
specific board, for instance, [coreboot], is not a suitable solution for this
task. The only exception to this rule is if you need to modify the firmware —
for example if coreboot doesn't already support the board you're using, and you
then decide to implement that support by yourself.

### Details

It's a misconception to believe that BIOS firmware is specifically designed
from the ground up to each motherboard. The truth is, several components of the
BIOS are common across different motherboards. This means that if you can find
a motherboard that's similar to yours, particularly one with the same chipset,
getting its BIOS working on your own motherboard might not be as challenging as
it appears.

This task involves locating two different motherboards with BIOSes made by
different manufacturers, such as one with Award Modular BIOS and another with
AMIBIOS. The goal is then to make the BIOS of one motherboard operate on the
other, for instance, running the Award Modular BIOS on the motherboard
initially equipped with AMIBIOS.

### Hints

> Work in progress.

### Solution

> Work in progress.

<!-- External links -->
[coreboot]: https://www.coreboot.org/

<!-- Included assets -->
[Award Modular BIOS v6.00PG]: ../../../assets/badges/award_6-00PG.svg