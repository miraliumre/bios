# The Disappearance Of The PC Speaker

![AMIBIOS 8]
![Award Modular BIOS v6.00PG]

> _Ever since I was created, I've come to realize I'm merely a rudimentary_
> _sound system. Even so, I'll keep on beeping for as long as I continue to_
> _exist._

### Objective

Customize the standard [Power-On Self-Test (POST) beep] with a personalized
tune of your preference.

### Overview

Early models of the IBM PC and its clones tipically featured an internal
[speaker] connected to the motherboard. It was generally driven by the
[Programmable Interval Timer (PIT)] and used to produce simple sounds, such as
beeps — at least until creative programmers started developing elaborate
[techniques] to play music and even speech through that same speaker.

As technology progressed and sound cards became more common, manufacturers 
started using [tiny speakers] in place of the bigger, more expensive ones.
Although the sound quality was lower, it wasn't an issue since the use of PC
speakers was on the decline.

In the present day, modern motherboards usually do not even include an onboard
speaker at all, although most of them still retain pins which allow users to
purchase and connect their own speaker if desired. One possible reason why one
might do this is for listening to the diagnostic beeps emitted by the PC's
firmware during startup. Nonetheless, this diagnostic method is also losing
relevance as manufacturers introduce alternative approaches for communicating
early boot issues, such as the [Asus Q-LED indicators].

For this challenge, the objective is to reverse engineer a BIOS, locate the
code responsible for playing the startup beep and then replace it with code
that plays a custom tune.

### Hints

> Work in progress.

### Solution

> Work in progress.

<!-- External links -->
[Asus Q-LED indicators]: https://www.asus.com/support/FAQ/1042678/
[Power-On Self-Test (POST) beep]: https://en.wikipedia.org/wiki/Power-on_self-test#Progress_and_error_reporting
[Programmable Interval Timer (PIT)]: https://wiki.osdev.org/Programmable_Interval_Timer
[speaker]: https://wiki.osdev.org/PC_Speaker
[techniques]: https://www.youtube.com/watch?v=jD4m9JvLy2Y
[tiny speakers]: https://commons.wikimedia.org/wiki/File:PC-Speaker_IMG_9311-9312.JPG

<!-- Included assets -->
[AMIBIOS 8]: ../../../assets/badges/amibios_8.svg
[Award Modular BIOS v6.00PG]: ../../../assets/badges/award_6-00PG.svg