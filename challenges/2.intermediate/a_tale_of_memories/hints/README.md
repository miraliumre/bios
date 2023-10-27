# Hints for A Tale of Memories

The `mdump` tool operates in two modes:

1. Bootable mode, that doesn't require explanation
2. Injectable mode. The injectable mode is a 'PIE-like' (Position-Independent 
Executable) mode ready to run from any point in the code, regardless of the 
chosen address.

The injectable mode only requires that the code be built as follows:
```bash
$ make clean         (a clean build is required)
$ make BOOTABLE=no
```

The resulting file, `mdump.img`, is ready to be injected wherever you desire, 
without altering its binary or source code.

## Where to Place It?
The big question is: where to put it, and what's the physical address of that 
location?

There are several places in the BIOS where `mdump` can be placed, but the only 
observation to be made is that the location needs to be empty, and that's 
tricky! Just looking for 'gaps' in the BIOS ROM doesn't imply that the memory 
position is empty: various locations might be data sections to be filled at 
runtime or even locations where the BIOS will extract its modules. There are no 
guarantees that any gap found will be truly empty at runtime unless you know 
what you're doing.

Furthermore, there's the issue of knowing the physical address of such gap, 
because your injected code needs to be invoked at some point. It may sound like 
the chicken and egg problem, but Pinczakko's 
[AMIBIOS8_1B_Utils](https://github.com/pinczakko/AMIBIOS8_1B_Utils) tool can 
provide the physical address at which each sub-module (of the 1B module) will 
be loaded into memory.

In the end, the answer you're looking for is: **VGA ROM**!!!

The VGA ROM has several advantages, including:
1. It's always extracted at `C000:0000`, so its address is predictable.
2. It's loaded at very early stages of the BIOS, which is fundamentally 
important.
3. There is usually plenty of free space available.

So, to summarize, you need to:
- Find an empty position within the VGA ROM (preferably after the last used 
byte, and give some extra space, like ~128 bytes, just to be cautious).
- Inject your code there.

The final address of your code will be: **0xC000:chosen_offset**, simple, isn't 
it?

## Where to Execute From?
Once the `mdump` code is injected, it also needs to be invoked from somewhere, 
which requires some care as well:
1. You can't invoke your code before the VGA ROM code exists in memory! 
Normally, this is not a big problem since the VGA ROM code is extracted very 
early, but it still requires some attention.
2. The `mdump` code requires that RAM memory be properly initialized (for 
obvious reasons). Again, this is not usually a problem unless you're trying to 
dump memory from the boot block; in that case, RAM is likely to be initialized. 
In case of doubt, look for instructions that use the stack, such as 
`push/pop/call/ret`.

A good place that covers both cases is the logo! When the BIOS decides to 
display the manufacturer's logo on the screen, the VGA ROM must already be up 
and running, and RAM memory as well.

How do you find this? It's not as complicated as it seems. Before drawing the 
logo, the BIOS changes the video mode using `INT 10H, AH = 4f02H - Set SuperVGA 
Video Mode`, and there's only one occurrence in the entire 1B module, easily 
found with ndisasm+grep:

```asm
$ ndisasm -b16 1b_module | grep "mov ax,0x4f02" -C 4
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

So, the offset you want to add your `call 0xC000:chosen_offset` (or `jmp 
0xC000:chosen_offset`) is `0x1239` in the 1B module. (Note that this offset is 
fake; you need to find it!)

There are many other places for this, and each place will provide a unique view 
of memory for that point in execution!
