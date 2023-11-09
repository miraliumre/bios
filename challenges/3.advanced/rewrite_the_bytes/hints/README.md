# Hints for Rewrite The Bytes
As previously mentioned, this challenge requires you to 'port' the BIOS from 
one manufacturer to another, such as from Award to AMIBIOS, provided they 
come from different motherboards.

It is essential to note that for this challenge, ROMs from 'rebranded' 
motherboards are **not valid**. In other words, identical models from 
different manufacturers, like the PCWare IPM41-D3, known for having various 
rebrandings such as Intel DG41WV or Positivo POS-PIG41BO, are **not 
accepted** for this challenge. The objective of this challenge is to perform 
the port between unrelated motherboards.

## So, which BIOS/motherboard to choose?
A common misconception when discussing BIOS is to claim that the BIOS ROM is 
exclusively tailored to one motherboard. This is not entirely accurate 
because a significant portion of BIOS code is motherboard-independent. This 
includes the setup code, module decompression algorithms, logo, video 
routines, and more.

What is motherboard-dependent can be divided into two main groups:
- Super I/O code
- Chipset code

The first is responsible for configuring most of the sensors on the 
motherboard, while the second is lower-level and is used to configure things 
like the DRAM controller, and etc.

Ideally, the easiest way to 'port' a ROM to another motherboard would be to 
find two distinct motherboards with the *same* Super I/O *and* Chipset. 
However, this is **very challenging** to find (except for rebranded 
motherboards, which are not within the scope of this challenge!). In most 
cases, the Super I/O is not even disclosed in the motherboard's 
specifications.

That said, you will have to sacrifice one of the two, and the **first tip** 
is: sacrifice the Super I/O!
The chipset is essential for the correct operation of the PC, as it is 
responsible for RAM, buses, and more. In fact, it *knows* the components of 
your motherboard, and without it, things won't work.

So, can a motherboard function without the Super I/O? It can, but it is 
highly not recommended, and that is what we are going to do here =).

## Meet the Gigabyte G41M Combo
This challenge assumes that you are attempting to port an Award BIOS to a 
motherboard originally equipped with AMI (in this case, the PCWare IPM41-D3). 
In this context, the Gigabyte G41M Combo is a good option.

Check out the specs below:
|                 | **PCWare IPM41-D3** |           **Gigabyte G41M Combo**          |
|:---------------:|:-------------------:|:------------------------------------------:|
| **Northbridge** |      Intel® G41     |                 Intel® G41                 |
| **Southbridge** |     Intel® ICH7     |                 Intel® ICH7                |
|  **Super I/O**  |  Winbond W83627DHG  |                ITE IT8718F-S               |
|   **ROM Type**  |    1M - DIP-8 ROM   | 2x 1M, SOP-8 ROM (Dual BIOS // backup ROM) |
| **BIOS Vendor** |       AMIBIOS8      |                Award 6.00PG                |

Although different from the PCWare IPM41-D3, both share the same chipset, and 
that is enough for our purposes.

Once you have chosen the target and destination motherboards (_and you are 
always free to choose others; everything in this hint is merely a 
suggestion_), how do you proceed with the hacking?

## How to hack?
This is an advanced challenge. Are you really looking for a step-by-step 
guide??

All jokes aside, there is no way to describe this generically, but here's a 
procedure that *I* would follow:

1. Flash the new ROM to the target motherboard.
2. Test.
3. Did it work?
4. If not, did anything appear on the screen, perhaps an error message?
5. Reverse Engineer.
6. Found something interesting? Modify.
7. Go back to step 1.

A final set of tips:
1. Print routines are valuable for finding certain points in the code.
2. Award BIOSes use `mov si, <str_offset>` for this purpose.
3. The `ffgroup.bin` module is the main and most important one.

Good luck =).
