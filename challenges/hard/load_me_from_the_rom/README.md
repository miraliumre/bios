# Load Me From The ROM

![Bootblock]

> _And let me play among the bytes._

### Goal

Develop a simple program that sends a message to the computer's serial port.
This program should start running from the [reset vector] address, and it must
function independently without needing any third-party code, such as the BIOS,
to be present in the ROM.

### Details

When powering on a x86 CPU, the microprocessor begins to perform instructions
located at `0xFFFFFFF0`, the reset vector. At startup, the chipset links this
address to the EEPROM, where the BIOS code is located. This allows the CPU to
begin executing the first instructions of the BIOS, which are sometimes
referred to as the _bootblock_.

This challenge consists of writing a program that runs directly from the reset
vector, without relying on the BIOS for initializing the system. The function
of the program should be to send a message over the computer's serial port.

### Hints

> Work in progress.

### Solution

> Work in progress.

<!-- External links -->
[reset vector]: https://en.wikipedia.org/wiki/Reset_vector

<!-- Included assets -->
[Bootblock]: ../../../assets/badges/bootblock.svg

