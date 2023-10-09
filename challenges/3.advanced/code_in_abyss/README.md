# Code In Abyss

![AMIBIOS 8]

> _The destination we aim for is deep, straight into the heart of confusion,_
> _an open trap of the abyss._

### Objective

Execute custom code within the System Management Mode ([SMM]), also referred to
as ring -2.

### Overview

Introduced by Intel in 1990 alongside the 386SL processor, SMM is a concept
that has since been adopted by AMD and other x86 manufacturers. Initially
conceived for power management and hardware control functionalities, SMM has
evolved to serve as a medium for a variety of operations, encompassing USB
legacy support, system security, and proprietary OEM features.

In the realm of a legacy BIOS, SMM lacked robust protective measures against
unauthorized modifications owing to the absence of a mechanism to isolate SMM
from the OS or mandate resources accessible by SMM. This vulnerability is a
well-documented attack vector for advanced [malware].

The endeavor in this challenge is to locate and modify SMM code within an
AMIBIOS 6 image, achieving execution of arbitrary code in the context of SMM.

### Hints

> Work in progress.

### Solution

> Work in progress.

<!-- External links -->
[malware]: https://www.microsoft.com/en-us/security/blog/2020/11/12/system-management-mode-deep-dive-how-smm-isolation-hardens-the-platform/
[SMM]: https://wiki.osdev.org/System_Management_Mode

<!-- Included assets -->
[AMIBIOS 8]: ../../../assets/badges/amibios_8.svg