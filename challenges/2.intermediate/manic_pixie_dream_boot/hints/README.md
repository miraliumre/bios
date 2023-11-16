# Hints for Manic PiXiE Dream Boot

In the original IBM PC, the boot process commenced with an interrupt request,
specifically INT 19h. This interrupt was triggered to initiate the booting
sequence. If, during this sequence, it was discovered that no bootable disk was
present, a subsequent interrupt request, INT 18h, was triggered to launch
[IBM Cassette BASIC] from the system's ROM.

However, IBM PC clones did not incorporate an onboard BASIC interpreter. This
was primarily due to the lack of popularity of this feature and the proprietary
nature of IBM's BASIC software, which legally restricted third-party
manufacturers from including it in their systems. In these clones, invoking INT
18h might merely result in displaying a message such as _"No ROM BASIC"_ or
_"No bootable disk available"_.

As time progressed, manufacturers repurposed INT 18h for initiating network
boot procedures. A network boot ROM would hook INT 18h, triggering the network
boot process when INT 18h was invoked by the computer's BIOS.

With the advent of industry standards like [Plug and Play (PnP)], the preferred
approach to implementing a network boot ROM shifted from hooking INT 18h to
utilizing the Bootstrap Entry Vector (BEV), a field in the PnP header of an
option ROM which causes the BIOS to treat that ROM as a boot option.

### The bottom line

To achieve the challenge's goal, you're expected to write your own option ROM
and use it to replace the pre-existing network boot ROM found in the original
BIOS firmware image.

For **AMIBIOS 8** firmware images, the network boot ROM is easily identifiable
and replaceable with the help of **[MMTool]**. The process is similar for
**Award Modular BIOS v6.00PG**, despite slightly more inconvenient considering
the less-than-friendly command line interface of **[CBROM]** and its tendency
to produce corrupted firmware images.

![MMTool]

To have your option ROM is identified as a boot option by the BIOS, you can
choose one of two paths:

1. Incorporate INT 18h into your option ROM's initialization code.
2. Add the PnP header and include the suitable BEV entry.

Regardless of your decision, it's recommended to start your research with
Compaq's [BIOS Boot Specification] document. Within this resource, look for
mentions of **PnP**, **BEV**, and **INT 18h**. This will be helpful, but be
prepared for additional research to create a comprehensive boot ROM as the
challenge demands.

<!-- External links -->
[BIOS Boot Specification]: https://www.scs.stanford.edu/nyu/04fa/lab/specsbbs101.pdf
[IBM Cassette Basic]: https://en.wikipedia.org/wiki/IBM_BASIC
[Plug and Play (PnP)]: https://en.wikipedia.org/wiki/Legacy_Plug_and_Play

<!-- Included assets -->
[MMTool]: MMTool_Network_Boot_ROM.png
[CBROM]: CBROM_Network_Boot_ROM.png
