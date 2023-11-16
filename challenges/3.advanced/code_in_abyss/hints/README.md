# Hints for Code in Abyss

[System Management Mode (SMM)] is a unique operational mode used by CPUs to
handle specific, critical scenarios like high temperatures or fan failures.
When certain conditions are met, the CPU switches to this mode in response to
System Management Interrupts (SMIs). These interrupts are often initiated by
the Super I/O or the chipset, though other triggering methods exist.

In SMM, code is executed in a distinct environment known as _ring -2_[^r2].
This refers to a level of operation below the normal user and kernel modes
(rings 0 to 3) of a computer system. The code in SMM operates in a 16-bit real
mode and can be activated at any point, regardless of whether an operating
system is running[^b4].

The memory region where SMM code runs is called System Management RAM (SMRAM).
This area is typically set to be read-only and is hidden from other operating
modes, making the code executing in SMM nearly[^nearly] invisible to the
operating system, antivirus software, and other utilities. For example, even
when performing a memory dump in ring 0 (the kernel mode), the contents of
SMRAM cannot be accessed or read, which can pose security risks as it becomes a
potential target for attackers.

This challenges consists of figuring out how to execute your own code in SMM
and where to correctly place it within the system's architecture. This involves
understanding both the triggering of SMIs and the management of the SMRAM.

[^r2]: Terms such as _ring -3_, _ring -2_ and _ring -1_ are informally used by
the community, and are used to refer to privilege levels beyond the officially
defined rings 0 to 3. Ring -1 generally refers to an [hypervisor], while ring
-2 usually refers to the SMM and ring -3 may refer to code executing on the
[Intel Management Engine (ME)]. 

[^b4]: A SMI can happen at any point and the operating system has limited
ability to address or prevent it.

[^nearly]: The term 'nearly' is used to indicate that, while it's generally
hard for an operating system to directly observe when an SMI is executed, there
might be indirect ways to infer its occurrence. One such indirect method is by
observing variations in the execution times of certain instructions. This
variation can occur because when an SMI is executed, it temporarily halts the
normal operation of the CPU, which can lead to a measurable delay in the
execution of other instructions.

### Understanding SMIs

[System Management Interrupts (SMIs)] are special events that occur under
certain hardware-specific conditions. Unlike traditional interrupts, they don't
use the [Interrupt Vector Table (IVT)] or [Interrupt Descriptor Table (IDT)].
Instead, they rely on the SMM Dispatch Table (SDT).

There are generally three strategies for working with SMIs:

1. **Exploiting vulnerabilities in existing handlers.** This involves finding
   and leveraging weaknesses in already existing SMI handlers.

2. **Creating your own handler.** This means adding a new handler to the
   system.

3. **Modifying existing handlers**: This approach focuses on altering an
   existing handler in the SDT, which we will focus on in this guide.

The key question is how to access and read the SDT. To address this, we
may use a specialized tool described in the following section.

### Introducing sdtlist

Developed by [Theldus], sdtlist is a compact utility that works with the
Single-Link Arch BIOS (`1B`) module of an AMIBIOS 8 ROM. Its primary function
is to enumerate all the handlers within the BIOS.

For instance, using sdtlist to inspect an ASUS P5Q motherboard's BIOS reveals
a comprehensive list of its handlers, as follows.

```text
$ ./sdt amibody.1b 
>> Found SMI dispatch table!
Size: 360 bytes
Entries: 15
Start file offset: 0x65cb1

>> SMI dispatch table entries:
Entry 0:
  Name: $SMICA
  Handle SMI ptr:  0xa8c86e4b
  Handle SMI foff: 0x47969
Entry 1:
  Name: $SMISS
  Handle SMI ptr:  0xa8c885b5
  Handle SMI foff: 0x490d3
Entry 2:
  Name: $SMIPA
  Handle SMI ptr:  0xa8c8891c
  Handle SMI foff: 0x4943a
Entry 3:
  Name: $SMISI
  Handle SMI ptr:  0xa8c89f7b
  Handle SMI foff: 0x4aa99
Entry 4:
  Name: $SMIX5
  Handle SMI ptr:  0xa8c89fd2
  Handle SMI foff: 0x4aaf0
Entry 5:
  Name: $SMIBP
  Handle SMI ptr:  0xa8c8a680
  Handle SMI foff: 0x4b19e
Entry 6:
  Name: $SMISS
  Handle SMI ptr:  0xa8c8a6c6
  Handle SMI foff: 0x4b1e4
Entry 7:
  Name: $SMIED
  Handle SMI ptr:  0xa8c8a7f2
  Handle SMI foff: 0x4b310
Entry 8:
  Name: $SMIFS
  Handle SMI ptr:  0xa8c8a853
  Handle SMI foff: 0x4b371
Entry 9:
  Name: $SMIPT
  Handle SMI ptr:  0xa8c8aa33
  Handle SMI foff: 0x4b551
Entry 10:
  Name: $SMIBS
  Handle SMI ptr:  0xa8c8ab12
  Handle SMI foff: 0x4b630
Entry 11:
  Name: $SMIVD
  Handle SMI ptr:  0xa8c8abdd
  Handle SMI foff: 0x4b6fb
Entry 12:
  Name: $SMIOS
  Handle SMI ptr:  0xa8c8ace7
  Handle SMI foff: 0x4b805
Entry 13:
  Name: $SMIBO
  Handle SMI ptr:  0xa8c8acfb
  Handle SMI foff: 0x4b819
Entry 14:
  Name: $DEF??
  Handle SMI ptr:  0xa8c8b3a7
  Handle SMI foff: 0x4bec5
```

The most crucial piece of information provided by sdtlist for this challenge is
the **Handle SMI foff** field. This indicates the physical file offset where a
particular handler is located, which is important for identifying and working
with these handlers. Additionally, the handler's name, as defined in the ROM,
can give clues about its function. For example, a handler named `$SMISS` is
related to managing sleep state in the system.

Several important considerations must be kept in mind when working with these
handlers:

- It's critical to be careful when choosing which handler to modify and what
  modifications apply, as any changes can easily disrupt the proper functioning
  of the BIOS and the system;

- To understand how a specific handler, like `$SMIABC`, is invoked, one must
  rely on reverse engineering. The handler would have to be analyzed to
  determine its role and how it is invoked in the system. Handlers can be quite
  diverse in their functionality and invocation. Some might be periodic, others
  might be event-driven, and they can vary based on system states or hardware
  conditions.

- The selection of a handler for further investigation depends on the specific
  requirements or interests of the programmer.

### The magical `$SMIED`

The `$SMIED` handler has a few fascinating characteristics. At first glance, it
appears to be "no-op", meaning it doesn't perform any obvious function.
However, it seems to be present across most, if not all, AMIBIOS 8 systems,
which suggests a hidden purpose. This handler can be triggered via software by
writing the value `0xDE` to port `0xB2`, as in `outb(0xDE, 0xB2)`.

For this challenge, you have the possibility to replace the `$SMIED` handler
with a custom handler of your choice. When doing this, it's crucial to be
mindful of the size of your replacement code to avoid interfering with other
handlers in the system.

Once your custom handler is in place, you can activate it from virtually any
environment (Linux, Windows, bootable code, etc.) simply by running code that
performs the function of `outb(0xde, 0xb2)`.

### Final note

None of this would be possible without [.:: A Real SMM Rootkit ::.], a somewhat
lengthy but definitely worth reading paper on Phrack that provides a very
in-depth and practical understanding of SMM.

You might also be interested in [SMMdump], a memory dump tool that runs in 
SMM mode from [Theldus], the same author of stdlist.

[.:: A Real SMM Rootkit ::.]: http://phrack.org/issues/66/11.html
[hypervisor]: https://en.wikipedia.org/wiki/Hypervisor
[Intel Management Engine (ME)]: https://en.wikipedia.org/wiki/Intel_Management_Engine
[Interrupt Descriptor Table (IDT)]: https://wiki.osdev.org/Interrupt_Descriptor_Table
[Interrupt Vector Table (IVT)]: https://wiki.osdev.org/Interrupt_Vector_Table
[SMMdump]: https://www.youtube.com/watch?v=gKA7HqrUtc8
[System Management Interrupts (SMIs)]: https://wiki.osdev.org/System_Management_Mode#Triggering_SMM
[System Management Mode (SMM)]: https://wiki.osdev.org/System_Management_Mode
[Theldus]: https://github.com/Theldus