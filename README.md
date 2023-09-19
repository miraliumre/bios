# BIOS

Welcome to RET·MOE's BIOS repository! Here, you'll find a list of resources
dedicated to BIOS reverse engineering, along with challenges designed to serve
as a starting point for those eager to delve into the realm of PC firmware
modification.

While the contents here exclusively focus on legacy PC firmware, we have plans
for an upcoming repository that will be entirely dedicated to UEFI.

## Challenges

### Easy

These challenges are straightforward and do not require any coding abilities or
previous knowledge on BIOS firmware. They can be quickly completed by any
person with minimal computer skills and are excellent for getting to know BIOS
modification tools such as CBROM and MMTool.

- [A Silent Boot]
- [Absolute Virtualization]
- [Twinkle Twinkle Energy Star]

### Normal

The challenges in this level require knowledge of 16-bit assembly programming
for the x86 architecture, the ability to analyze and modify binary programs by
using reverse engineering tools (such as [Ghidra] or [radare]) and a basic
understanding of the typical structure of BIOS firmware.

- [A Tale Of Memories]
- [Manic PiXiE Dream Boot]
- [The Disappearance Of The PC Speaker]

### Hard

In addition to 16-bit assembly programming and reverse engineering skills,
these challenges require a more in-depth understanding of BIOS firmware, the
specific design of the motherboard being worked on, and the x86 architecture.
They can be time-consuming to complete, even for those who are most
experienced.

- [Code In Abyss]
- [Load Me From The ROM]
- [Rewrite The Bytes]

## Links

Third-party recommended resources about BIOS hacking.

- [AMI BIOS Code Injection]  
  A repository by [Davidson Francis]

- [Magnolia]  
  An experimental legacy Option ROM project by [Miralium Research]

<!-- Challenges -->
[A Silent Boot]: challenges/easy/a_silent_boot/README.md
[A Tale Of Memories]: challenges/normal/a_tale_of_memories/README.md
[Absolute Virtualization]: challenges/easy/absolute_virtualization/README.md
[Code In Abyss]: challenges/hard/code_in_abyss/README.md
[Load Me From The ROM]: challenges/hard/load_me_from_the_rom/README.md
[Manic PiXiE Dream Boot]: challenges/normal/manic_pixie_dream_boot/README.md
[Rewrite The Bytes]: challenges/hard/rewrite_the_bytes/README.md
[The Disappearance Of The PC Speaker]: challenges/normal/the_disappearance_of_the_pc_speaker/README.md
[Twinkle Twinkle Energy Star]: challenges/easy/twinkle_twinkle_energy_star/README.md

<!-- External links -->
[AMI BIOS Code Injection]: https://github.com/Theldus/AMI_BIOS_CodeInjection
[Davidson Francis]: https://github.com/theldus
[Ghidra]: https://ghidra-sre.org
[Magnolia]: https://github.com/MiraliumRe/magnolia
[Miralium Research]: https://miralium.re
[radare]: https://rada.re/