# Hints for Load Me From The ROM

This challenge requires you to write a BIOS (or bootblock)[^bb] from scratch
that, when the PC is powered on, sends any message to the serial port.

Contrary to what many may think, it is entirely possible to write a BIOS from
scratch (Coreboot is there to prove my point), and it is _not as difficult_
as it may seem, provided your expectations and objectives are well
calibrated. The concept of BIOS is extensive, and it is responsible for
various functions. However, in this challenge, we will focus on a simpler
concept: BIOS is the first piece of code to be executed when a CPU is powered
on, and that is precisely what this challenge asks you to accomplish.

[^bb]: In general, the bootblock is the initial piece of code in the BIOS
that is executed when a PC is powered on. However, 'bootblock' is just a
concept introduced by BIOS manufacturers to refer to the uncompressed initial
code of the ROM. For this challenge, bootblock and BIOS are effectively the
same thing: just code stored in ROM memory and executed when the PC is
powered on.

### CPU Initialization and the lonely desert

When the PC is powered on, the chipset maps the _end_ of the ROM to the end
of physical memory, and the first instruction (or the 'reset vector',
entrypoint, etc.) to be executed will be present/mapped at `FFFF_FFF0`
(`FFFF:FFF0` on real mode). In other words, the final 16 bytes of RAM are
mapped to the final 16 bytes of the ROM, and this will be your entrypoint. To
put it even more simply, a 1MB ROM will have its first instruction executed
at the offset `1M-16 bytes` of the ROM!

Quoting from the Intel manual ([Intel SDM], Vol 3A, Chap 10):

> **10.1.4 First Instruction Executed**
>
> The first instruction that is fetched and executed following a hardware
reset is located at physical address FFFFFFF0H. This address is 16 bytes
below the processor’s uppermost physical address. The EPROM containing the
software-initialization code must be located at this address.
>
> The address FFFFFFF0H is beyond the 1-MByte addressable range of the
processor while in real-address mode. The processor is initialized to this
starting address as follows. The CS register has two parts: the visible
segment selector part and the hidden base address part. In real-address mode,
the base address is normally formed by shifting the 16-bit segment selector
value 4 bits to the left to produce a 20-bit base address. However, during a
hardware reset, the segment selector in the CS register is loaded with F000H
and the base address is loaded with FFFF0000H. The starting address is thus
formed by adding the base address to the value in the EIP register (that is,
FFFF0000 + FFF0H = FFFFFFF0H).
>
> The first time the CS register is loaded with a new value after a hardware
reset, the processor will follow the normal rule for address translation in
real-address mode (that is, [CS base address = CS segment selector * 16]). To
ensure that the base address in the CS register remains unchanged until the
EPROM based software-initialization code is completed, the code must not
contain a far jump or far call or allow an interrupt to occur (which would
cause the CS selector value to be changed).

For further information on the initial state of the CPU, please see Intel SDM
Volume 3A, Chapter 10, "Processor Management and Initialization."

### The lonely desert

In this initial stage, the CPU runs on real mode, and executes code directly
from the ROM, a technique called '_execute-in-place_'. This happens because
the CPU has yet to 'learn' how to access RAM, and all accesses to it are
forwarded to the ROM by the chipset.

In fact, at this stage, **_nothing_** has been initialized yet, and you **_do
not have available_**:

1. Stack, as the DRAM controller of the chipset has not been configured yet.
2. Video, due to 1) and also because you need to manually configure the video
(with VGA registers, etc.).
3. Serial or keyboard or any type of I/O: since the Super I/O has **also**
not been configured.

So... what can you do?
- Write code that **does not** use I/O for external devices.
- **Do not** write to RAM, after all, you don't have RAM!
- Use **only** the CPU registers (GPRs, FPU, etc.).

At this point, you essentially have a piece of software that is blind, deaf,
and mute. Nice, isn't it?

## Exiting the desert

To recap, this challenge requires you to perform I/O with the external world
via the serial port, so something needs to be done about that.

The main hints for this challenge are:
1. Enable LPC (Low Pin Count) decoding on the chipset.
2. Configure GPIO pins on the Super I/O for UART.
3. Configure/activate UART on the Super I/O.
4. Configure the UART device (baud rate, etc.).

Additional tips:
1. Refer to the datasheet of the Intel ICH7 chipset.
2. Refer to the datasheet of the Super I/O Winbond W83627DDHG.
3. Intel SDM is always welcome (Vol 3A, Chap 10 is especially useful:
_'Processor Management and Initialization'_).

The above tips have been validated on the IPM41-D3 motherboard but may be
applicable to other motherboards with slight adaptations. Also, don't forget
that this motherboard is supported by [coreboot], and reading its code might
come in handy.

Another interesting project is [UBRX], a bootblock/BIOS designed for PC
recovery in very early stages. It is created by the same author as Rufus and
has well-written and fascinating code to explore.

### Extra: obtaining memory and moving forward

For this challenge, it is not necessary to use RAM, and it is perfectly
possible to do everything without it, but I believe it's still interesting to
mention.

Configuring RAM properly is definitely not an easy task, but there is a much
easier and faster way to have RAM, called 'Cache-as-RAM' or CAR. CAR is an
old feature of Intel processors (probably since the i486) where you can use
the processor's own cache as main memory. Although limited, even old
processors have some kilobytes of memory in the L1 level, and much more in
the L2 and L3 levels. For small code like an assembly-written bootblock, a
few kilobytes of memory are more than enough.

Some tips for setting up CAR:
1. Enable the use of MTRR registers.
2. Configure the use of MTRRs for a specific memory range: either the
fixed-range MTRRs or the configurable ones.
3. Enable the cache.
4. 'Touch' all cache lines in the desired memory range.
5. Disable the cache again.

Note that the memory range size you choose directly reflects which cache
level to use: if you want to use L2 cache, you need to force the data to go
beyond L1 and touch your L2 cache lines!

A good starting reference for CAR can be found in [UBRX - L2 cache as
instruction RAM (CAiR)]. The paper entitled [CAR: Using Cache as RAM in
LinuxBIOS] also provides a good introduction and historical context of
when CAR was introduced in LinuxBIOS (predecessor of Coreboot).

Another interesting advantage of using CAR is that, in addition to the stack,
it becomes possible to make the processor jump to protected mode and thus
execute 32-bit code in C, fantastic, isn't it?

## Final thoughts

When I wrote my first bootblock/BIOS code, many things became clear and
demystified, such as the need for RAM for a computer to work, and the entire
structure of the BIOS ROM: checksum, compressed modules, etc. All of this is
software, and there is nothing at the hardware level that says it must be
this way, which was quite revealing for me.

So, I believe the main goal of this challenge is to demystify what a BIOS
actually is, how it works, how it is (or can be) internally organized, what
is strictly necessary or not, etc. I hope that by the end of the challenge,
this goal has been achieved.

Good luck!

<!-- External links -->
[CAR: Using Cache as RAM in LinuxBIOS]: https://www.coreboot.org/data/yhlu/cache_as_ram_lb_09142006.pdf
[coreboot]: https://github.com/coreboot/coreboot/tree/master/src/mainboard/intel/dg41wv
[Intel SDM]: https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
[UBRX - L2 cache as instruction RAM (CAiR)]: https://pete.akeo.ie/2011/08/ubrx-l2-cache-as-instruction-ram.html
[UBRX]: https://github.com/pbatard/ubrx