# Load Me From The ROM

![Bootblock]

> _And let me play among the bytes._

### Objective

Craft a simplistic program designated for transmitting a message through the
computer's serial port. This program shall commence its operation from the
[reset vector] address, functioning autonomously without depending on any
external programs, such as the BIOS, residing in the ROM.

### Overview

Upon being powered on, a CPU based on the x86 architecture initiates the
execution of instructions present at the memory address `0xFFFFFFF0`, known as
the x86 reset vector.

The motherboard's chipset maps the reset vector address to the EEPROM, where
the BIOS code is harbored. This enables the CPU to execute the initial
instructions of the BIOS, oftentimes referred to as the _bootblock_.

The essence of this challenge lies in the construction of a program that
operates directly from the reset vector, not depending on the BIOS for any
system initialization functions. The program must be able to transmit a message
via the computer's serial port.

### Hints

If you require additional information to accomplish this challenge, please
refer to the [hints] file.

### Solution

> Work in progress.

<!-- External links -->
[reset vector]: https://en.wikipedia.org/wiki/Reset_vector

<!-- Internal links -->
[hints]: hints/README.md

<!-- Included assets -->
[Bootblock]: ../../../assets/badges/bootblock.svg

