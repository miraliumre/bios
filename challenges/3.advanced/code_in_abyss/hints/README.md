# Hints for Code in Abyss
As previously introduced, code in 'System Management Mode' (SMM) is a special 
code executed by the CPU for very specific scenarios, such as high temperature, 
low or no fan rotation, and so on. Its interruptions, known as System 
Management Interrupts (SMIs), are typically triggered by the Super I/O or 
chipset, although other methods exist.

Commonly referred to as `ring -2`[^r2], code in SMM runs in real mode, 16-bit, 
and can be triggered at any time, whether already within an operating system or 
before its execution[^b4]. Furthermore, the memory area in which SMM code runs 
is referred to as `SMRAM`, typically set as read-only, and code outside of SMM 
mode cannot even see the code.

That being said, code executing in SMM mode is nearly[^almost] invisible to an 
operating system, antivirus software, and so on. Memory dumps (even in ring 0!) 
cannot read the content of SMRAM. This makes it a fertile ground for attackers!

But one question remains: how do you execute your code in SMM mode, and where 
should you place it?

[^r2]: Technically, 'ring -2' does not exist (just like any of the negative 
rings). The '-2' designation is used because code in SMM mode runs with certain 
restrictions that prevent code in ring 0 from accessing SMRAM, and so on. 
Additionally, the '-1' ring (also informal) is said to be the Hypervisor.

[^b4]: An SMI can occur at any time, and there is not much an operating system 
can do about it.

[^almost]: 'Nearly' because it may be possible for an operating system to 
obtain indirect information that an SMI has been executed, such as differences 
in the execution times of specific instructions (although this can also be 
mitigated).

## Where to place? How to execute?

As mentioned earlier, SMIs are a kind of event generated when specific 
conditions (usually related to hardware) are met. As the name implies, they are 
called 'interrupts', but not in the same sense as traditional interrupts that 
use IVT/IDT. Instead, they also have a table, known as the SMM Dispatch Table 
(SDT).

In general, there are three approaches:

1. Discover a vulnerability in an existing handler.
2. Add your own handler.
3. Hack an existing handler.

In this guide, we will focus on the last option, which involves hacking an 
existing handler in the SDT.

But one question remains, how do you 'read the SDT'? For this purpose, I 
present `sdtlist`.

### `sdtlist`

`sdtlist` is a small tool created by me (@Theldus). Given the '1B' module of an 
AMIBIOS8 BIOS, it lists all the handlers present within it. As an example, here 
are all the handlers from the ASUS P5Q motherboard:

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

The only field of interest is `Handle SMI foff`, which indicates the physical 
offset in the file to which that handler belongs. The handler's name (defined 
by the ROM) can also provide a good suggestion of what the handler does. For 
example, `$SMISS` is the handler that handles 'Sleep State' requests.

Several questions arise:

1. Can I then change any handler? No, never!
2. I've chosen `$SMIABC`, how is it invoked? I don't know. You must reverse 
engineer the handler and investigate its functionality in the system. Different 
handlers are invoked in different ways and contexts. Some are periodic, while 
others are not. Some occur when your hardware is malfunctioning, while others 
are used to extend functionality. It varies.
3. So, which one should I choose? Let's move to the next section.

## Get to know the magical `$SMIED` handler!

The most intriguing handler of all is undoubtedly the `$SMIED` handler, for a 
few reasons:

1. It *appears* to be a 'no-op' and doesn't seem to serve any useful purpose.
2. It seems to be present in all AMIBIOS8 systems.
3. It can be triggered in software by writing the value `0xDE` to port `0xB2`, 
as in: `outb(0xDE, 0xB2)`.

### So, what should I do?

1. Replace the `$SMIED` handler (or another if you're feeling lucky!) with one 
of your preference. Be cautious about the size of your code to avoid 
overwriting other possible handlers, and etc.
2. Invoke your handler from anywhere using `outb(0xde, 0xb2)` (literally from 
anywhere, even within Linux, Windows, bootable code, or any other environment).

## Good references & final thoughts

None of this would be possible without the incredible text on SMM: [.:: A Real 
SMM Rootkit ::.]. It's a somewhat lengthy but definitely worth reading text 
that provides a very practical understanding of the subject.

You might also be interested in [SMMdump], a memory dumper tool that runs in 
SMM mode written by me.

[.:: A Real SMM Rootkit ::.]: http://phrack.org/issues/66/11.html
[SMMdump]: https://www.youtube.com/watch?v=gKA7HqrUtc8
