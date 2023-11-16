# BIOS

> ⚠️ **Important:** by using this repository and the contents herein, you
> acknowledge that you have read, understood and accept the [disclaimer].

Welcome to the **Miralium Research BIOS Repository**! This repository offers a
curated selection of resources and challenges dedicated to the exploration and
understanding of BIOS firmware reverse engineering and modification.

While our focus primarily lies on legacy PC firmware, we are in the process of
developing a new repository solely dedicated to UEFI, expected to be launched
in the near future.

## Challenges

Embark on a journey through varying levels of challenges tailored to provide a
hands-on experience in BIOS reverse engineering and modification.

### Tags

Each challenge is marked with one or more of the following tags.

![AMIBIOS 8] ![Award Modular BIOS v6.00PG] ![Award Modular BIOS v4.51PG]
![Bootblock]

The version tags indicate the firmware versions that the challenge has been
validated on. They do NOT indicate that the challenge is only appliable to
those versions. Enthusiasts are encouraged to experiment with other versions,
although such attempts were not tested by the authors of this repository.

The _Bootblock_ tag is an exception, as it is used to indicate a unique
challenge which consists of writing firmware-level code from scratch and is,
therefore, unrelated to existing platforms.

### Difficulty levels

#### Beginner

Perfect for individuals new to BIOS firmware, these challenges require no prior
coding knowledge. They serve as an excellent introduction to BIOS modification
tools like CBROM and MMTool.

- [A Silent Boot]
- [Absolute Virtualization]
- [Twinkle Twinkle Energy Star]

#### Intermediate

These challenges demand a fundamental understanding of 16-bit assembly
programming for x86 architecture, and basic proficiency in analyzing and
modifying binary programs using reverse engineering tools such as [Ghidra] or
[radare]. A basic grasp of BIOS firmware structure is beneficial.

- [A Tale Of Memories]
- [Manic PiXiE Dream Boot]
- [The Disappearance Of The PC Speaker]

#### Advanced

For the seasoned explorers, these challenges require a deeper comprehension
of BIOS firmware, specific motherboard designs, and the x86 architecture. They
pose a more complex, time-demanding venture even for the experienced.

- [Code In Abyss]
- [Load Me From The ROM]
- [Rewrite The Bytes]

## Links

Below is a collection of external resources recommended for those interested on
delving deeper into BIOS hacking.

- **[AMI BIOS Code Injection]**  
  A repository curated by Davidson Francis ([@Theldus])

- **[Magnolia]**  
  An experimental legacy Option ROM project led by [Miralium Research]

<!-- Included assets -->
[AMIBIOS 8]: assets/badges/amibios_8.svg
[Award Modular BIOS v4.51PG]: assets/badges/award_4-51PG.svg
[Award Modular BIOS v6.00PG]: assets/badges/award_6-00PG.svg
[Bootblock]: assets/badges/bootblock.svg

<!-- Challenges -->
[A Silent Boot]: challenges/1.beginner/a_silent_boot/README.md
[A Tale Of Memories]: challenges/2.intermediate/a_tale_of_memories/README.md
[Absolute Virtualization]: challenges/1.beginner/absolute_virtualization/README.md
[Code In Abyss]: challenges/3.advanced/code_in_abyss/README.md
[Load Me From The ROM]: challenges/3.advanced/load_me_from_the_rom/README.md
[Manic PiXiE Dream Boot]: challenges/2.intermediate/manic_pixie_dream_boot/README.md
[Rewrite The Bytes]: challenges/3.advanced/rewrite_the_bytes/README.md
[The Disappearance Of The PC Speaker]: challenges/2.intermediate/the_disappearance_of_the_pc_speaker/README.md
[Twinkle Twinkle Energy Star]: challenges/1.beginner/twinkle_twinkle_energy_star/README.md

<!-- External links -->
[@Theldus]: https://github.com/theldus
[AMI BIOS Code Injection]: https://github.com/Theldus/AMI_BIOS_CodeInjection
[Ghidra]: https://ghidra-sre.org
[Magnolia]: https://github.com/MiraliumRe/magnolia
[Miralium Research]: https://miralium.re
[radare]: https://rada.re/

<!-- Internal links -->
[disclaimer]: DISCLAIMER.md