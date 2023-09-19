# Code In Abyss

![AMIBIOS 8]

> _The destination we aim for is deep, straight into the heart of confusion,_
> _an open trap of the abyss._

### Goal

Execute custom code within the System Management Mode ([SMM]), also known as
as ring -2.

### Details

Introduced by Intel in 1990 with the 386SL processor, SMM is a concept that
has been adopted by AMD and other x86 manufacturers. Initially designed for
power management and hardware control, SMM has evolved to function as a medium
for a range of operations, including USB legacy support, system security, and
proprietary OEM features.

In the context of a legacy BIOS, SMM lacked protective measures against
unauthorized changes due to the absence of a mechanism to isolate SMM from the
OS or mandate resources accessible by SMM. That vulnerability is a
well-documented attack vector for advanced [malware].

The goal with this challenge is to locate and modify SMM code within an AMIBIOS
6 image, archieving execution of arbitrary code in the context of SMM.

### Hints

> Work in progress.

### Solution

> Work in progress.

<!-- External links -->
[malware]: https://www.microsoft.com/en-us/security/blog/2020/11/12/system-management-mode-deep-dive-how-smm-isolation-hardens-the-platform/
[SMM]: https://wiki.osdev.org/System_Management_Mode

<!-- Included assets -->
[AMIBIOS 8]: ../../../assets/badges/amibios_8.svg