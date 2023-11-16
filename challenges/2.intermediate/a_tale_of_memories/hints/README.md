# Hints for A Tale of Memories

The mdump tool is a versatile program capable of operating in two distinct
modes:

1. **Bootable mode.** The default mode of operation, where mdump is expected to
   be loaded from the MBR.

2. **Injectable mode.** Functions similarly to a
   [Position-Independent Executable (PIE)], meaning it can execute from an
   arbitrary injection point in the BIOS firmware, regardless of the memory
   address it has been loaded to.

### Compiling mdump for injection

To use injectable mode, the code must be compiled with the following commands:

```bash
make clean         # Ensures a clean build environment
make BOOTABLE=no   # Configures for non-bootable, injectable mode 
```

The output file named `mdump.img` will be ready for injection into the desired
location without requiring any modifications.

### Deciding on the injection point

In order to choose a suitable location in the BIOS ROM image to inject mdump,
you might want to adhere to the following tips.

- Seek out areas in the BIOS ROM where mdump can be injected. It's essential
  to identify a genuinely vacant memory region, as appearances can be
  deceptive. Some regions might look empty at first glance but turn out to be
  reserved for runtime data or module extraction by the BIOS.

- To actually execute code the injected code, you will need to determine at
  which memory address it will be present during runtime. This is a challenging
  task, but it can be approached in a variety of ways:
  
    - you could analyze memory dumps produced by the mdump tool running in
      bootable mode;
      
    - for AMIBIOS, an option is to use Pinczakko's [AMIBIOS_1B_Utils] to reveal
      the runtime addresses of modules within AMIBIOS' _Single-Link Arch BIOS_
      module;
      
    - lastly, you could make educated guesses based on the available
      documentation and on reverse engineering BIOS source code.

### The video BIOS

Modding the [video BIOS] to inject mdump is an appealing option for several
reasons:

- it is always extracted at the C000:0000 memory address;
- it is loaded very early in the BIOS initialization sequence;
- typically, it has plenty of empty spaces available.

If you choose the video BIOS as your injection point, you will want to locate a
vacant space within the VGA ROM, ideally beyond the last utilized byte, and
give it some extra space (maybe about ~128 bytes) for safety. After injection,
mdump will then predictably be made available during runtime at memory address
`0xC000:[YOUR_CHOOSEN_OFFSET]`.

### Jump point

Once mdump has been injected in the BIOS ROM, its code must be actually
executed (e.g. via a strategically-placed `jmp` instruction). To choose an
ideal jump point, the following must be taken into consideration.

1. **Video initialization.** The execution of mdump must occur **after** the
   video BIOS code is loaded into memory. This is usually not an issue as the
   video BIOS is typically loaded early in the boot process, but you might wish
   to double-check in order to avoid conflicts;

2. **RAM initialization.** mdump code relies on the RAM having already been
   properly initialized by the BIOS. To ensure the RAM is ready at your chosen
   jump point, look for operations involving the stack, such as `push`, `pop`,
   `call` and `ret` instructions.

A reliable jump point to invoke mdump from is right before the display of the
OEM logo splash screen. At this stage, the video ROM has already been loaded
and the RAM has been initialized.

To find the point in code where the BIOS displays the OEM logo, you might want
to look for video mode changes and, more specifically, the
[Set SuperVGA Video Mode] (`INT 10h / AX = 4F02h`) function.

The following excerpt of reverse engineered assembly code from a Single-Link
Arch BIOS module extracted from a sample AMIBIOS ROM image demonstrates how the
BIOS sets up the video mode for displaying the OEM logo. Notice the
`mov ax, 0x4f02` instruction which is subsequently followed by `int 0x10`.

```bash
ndisasm -b16 1b_module | grep "mov ax,0x4f02" -C 4
00001234  06                push es
00001235  1E                push ds
00001236  07                pop es
00001237  8BD8              mov bx,ax
00001239  B8024F            mov ax,0x4f02 <<<<<< here
0000123C  CD10              int 0x10
0000123E  07                pop es
0000123F  C3                ret
00001240  6650              push eax
```

In this example, you would replace the `mov ax, 0x4f02` instruction at offset
`0x1239` with a `jmp` to the mdump code at `0xC000:[YOUR_CHOOSEN_OFFSET]`.

### Final note

Different injection points can provide varied perspectives of memory at
different execution stages. It's important to choose the one that best fits
your diagnostic or debugging needs.

<!-- External links -->
[AMIBIOS_1B_Utils]: https://github.com/pinczakko/AMIBIOS8_1B_Utils
[Position-Independent Executable (PIE)]: https://www.redhat.com/en/blog/position-independent-executables-pie
[video BIOS]: https://en.wikipedia.org/wiki/Video_BIOS
[Set SuperVGA Video Mode]: https://www.ctyme.com/intr/rb-0275.htm