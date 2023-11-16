# Hints for Rewrite The Bytes

This challenge involves modifying a BIOS ROM image from one motherboard in 
order to run it on another.

To be clear, we are talking about different motherboards from distinct
manufacturers, meaning motherboards that are essentially rebranded versions of
the same model (e.g. PCWare IPM41-D3, Intel DG41WV, Positivo POS-PIG41BO) are
not suitable for this task.

### Choosing a BIOS and motherboard

It's a common misbelief that BIOS ROM is exclusively designed for a single
motherboard model. In reality, a substantial part of the BIOS code is
universal, encompassing elements like setup routines, module decompression and
video operations.

From the sections that are motherboard-specific, we must highlight the routines
associated with the [Super I/O] and the [chipset].

Ideally, to make a BIOS port such as proposed in this challenge viable, you
would select two motherboards with identical Super I/O and chipset. However,
finding such a pair, excluding rebranded motherboards, is exceedingly rare.
Often, the Super I/O model isn't even listed in the motherboard technical
specifications documents published by manufacturers.

As you will likely need to compromise on either an identical Super I/O or
chipset, you should prioritize choosing two motherboards with the same chipset.
That is because the chipset plays a crucial role in the PC's functionality,
managing components like RAM and buses. Super I/O compatibility is not
essential to get a working BIOS ROM.

### Example: the IPM41-D3 and the Gigabyte GA-G41M-Combo

As the challenge consists of porting an Award BIOS ROM onto a motherboard which
was originally equipped with AMIBIOS, porting the BIOS ROM from the
[Gigabyte GA-G41M-Combo] to the [IPM41-D3] is a valid solution.

This pair of motherboards share the same [Intel G41] northbridge and the 
[Intel ICH7] southbridge, but differ in their Super I/O, as the IPM41-D3 uses
the Winbond W83627DHG and the GA-G41M-Combo uses the ITE IT8718F-S, as per the
comparsion table below.

|                 |   **IPM41-D3**    |      **GA-G41M-Combo**      |
|:---------------:|:-----------------:|:---------------------------:|
| **Northbridge** |     Intel G41     |          Intel G41          |
| **Southbridge** |     Intel ICH7    |          Intel ICH7         |
|  **Super I/O**  | Winbond W83627DHG |        ITE IT8718F-S        |
|   **ROM Type**  |   1M - DIP-8 ROM  | 2x 1M SOP-8 ROM (Dual BIOS) |
| **BIOS Vendor** |     AMIBIOS 8     |        Award 6.00PG         |

If you choose to go ahead with this pair of motherboards, a clue to keep track
of is the `FFGROUP.BIN` module that can be found on the GA-G41M-Compo's BIOS
ROM images. 

### Tips

In order to accomplish the challenge, you might follow a procedure like this:

1. flash the BIOS ROM image from your source motherboard to your target
   motherboard;

2. if it does not work, start by observing the target motherboard's behavior
   and try to make educated guesses as for what might have gone wrong;

3. investigate the source motherboard BIOS ROM by reverse engineering it;

4. look to modify the aspects of the source motherboard's BIOS which might be
   blocking the target motherboard from booting correctly.
   
**Notes:** looking for print routines is an useful strategy for pinpointing
specific locations within your code; in the context of Award BIOSes, an
instruction such as `mov si, [str_offset]` is commonly employed as part of a
print routine.

Good luck! =)

<!-- External links -->
[chipset]: https://en.wikipedia.org/wiki/Chipset
[Gigabyte GA-G41M-Combo]: https://www.gigabyte.com/br/Motherboard/GA-G41M-Combo-rev-20
[Intel G41]: https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4-chipset-family-datasheet.pdf
[Intel ICH7]: https://www.intel.com/content/dam/doc/datasheet/i-o-controller-hub-7-datasheet.pdf
[IPM41-D3]: http://pcwarebr.com.br/produtos_mb_ipm41-d3.php
[Super I/O]: https://en.wikipedia.org/wiki/Super_I/O