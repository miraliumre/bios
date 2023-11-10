# Hints for The Disappearance Of The PC Speaker

The OSDev Wiki offers a comprehensive [guide] on the PC Speaker and how it can
be operated. For generating basic sounds like the beep heard during the POST,
the sensible choice is to use the PIT. It is safe to assume that most, if not
all, legacy BIOSes use this method.

### The bottom line

Here, we provide a minimalistic [program] crafted in 16-bit real mode assembly,
intended to be executed from the [Master Boot Record (MBR)]. It employs the PIT
to generate a beep from the PC speaker before halting.

In order to accomplish the challenge, when reverse engineering your BIOS image,
it might help to search within pertinent modules for code segments that execute
sequences of instructions similar to those which appear on the provided sample
code, such as writing to I/O ports `0x43` and `0x42.`

Good luck!

<!-- External links -->
[guide]: https://www.asus.com/support/FAQ/1042678/
[Master Boot Record (MBR)]: https://wiki.osdev.org/MBR_(x86)

<!-- Internal links -->
[program]: beep.asm