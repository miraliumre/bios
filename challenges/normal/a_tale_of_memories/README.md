# A Tale Of Memories

![AMIBIOS 8]
![Award Modular BIOS v6.00PG]

> _Regardless of how valuable the data in RAM may be, once the power is off,_
> _it inevitably gets cleared. What truly matters is what you do while the PC_
> _is running, so you can power it down without any regrets._

### Goal

Perform a dump of the RAM contents during the [POST].

### Details

Having a clear understanding of the RAM memory's layout at specific moments
during the BIOS code execution is not only helpful but often essential for
achieving certain BIOS hacking tasks.

For this very purpose, [Davidson Francis] has developed an utility
called [mdump]. This tool is entirely coded in assembly language and can 
be executed as bootable code. However, it's crucial to note that the state of
the computer's memory after the BIOS has completed its execution might differ
significantly from the state at the specific point where you intend to insert
your own code.

The challenge here is to inject mdump into the BIOS itself and use it to obtain
a memory dump from the early boot phase.

### Hints

> Work in progress.

### Solution

> Work in progress.

<!-- External links -->
[mdump]: https://github.com/Theldus/AMI_BIOS_CodeInjection/tree/main/tools/mdump
[POST]: https://en.wikipedia.org/wiki/Power-on_self-test
[Davidson Francis]: https://github.com/Theldus

<!-- Included assets -->
[AMIBIOS 8]: ../../../assets/badges/amibios_8.svg
[Award Modular BIOS v6.00PG]: ../../../assets/badges/award_6-00PG.svg