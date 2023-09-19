# Absolute Virtualization

![Award Modular BIOS v4.51PG]

> _In this rapidly advancing digital world, doomed to repeat its bugs and_
> _malfunctions, I envisioned a software I once knew and glimpsed its familiar_
> _interface once more._

### Goal

Use the Award Modular BIOS v4.51PG as a BIOS on [QEMU].

### Details

QEMU incorporates a `-bios` command line flag that allows users to designate a
firmware file for the simulated machine to utilize. However, the functionality
of this feature is not guaranteed with just any BIOS or UEFI image downloaded
from a motherboard manufacturer's site.

QEMU uses the concept of _machine types_, which refers to the general structure
and features of the simulated machine that may include elements like the
chipset and peripherals. Machine types align closely with the motherboard model
in an actual system and can be designated through the `-M` or `--machine`
parameter upon initiating QEMU.

For emulating an `i386` or `x86_64` machine, the most frequently utilized
machine type is `pc`, which, as per the [documentation], simulates, along with
a PIIX southbridge the [Intel i440FX] – a chipset popular in the late 90s.

Beyond `pc`, QEMU supports another machine type, `q35`, which simulates an
[ICH9] southbridge and the [Intel Q35], a chipset launched in 2007 for business
and embedded computing applications. Given that `q35` is a more recent
development, it's reasonable to expect this emulation to be less mature than
the `pc` machine type.

Ultimately, the challenge consists in locating a BIOS image compatible with the
hardware that QEMU emulates.

### Hints

No hints are available for this challenge.

### Solution

> Work in progress.

<!-- External links -->
[Intel i440FX]: https://en.wikipedia.org/wiki/Intel_440FX
[ICH9]: https://en.wikipedia.org/wiki/I/O_Controller_Hub#ICH9
[documentation]: https://www.qemu.org/docs/master/system/i386/pc.html
[Intel Q35]: https://www.intel.com/Assets/PDF/prodbrief/317312.pdf
[QEMU]: https://www.qemu.org/

<!-- Included assets -->
[Award Modular BIOS v4.51PG]: ../../../assets/badges/award_4-51PG.svg