# welcome another buffer thought active
software editor thought active microsoft and IBM rexx lang

Buffer overflow protection

    Article
    Talk

    Read
    Edit
    View history

From Wikipedia, the free encyclopedia

Buffer overflow protection is any of various techniques used during software development to enhance the security of executable programs by detecting buffer overflows on stack-allocated variables, and preventing them from causing program misbehavior or from becoming serious security vulnerabilities. A stack buffer overflow occurs when a program writes to a memory address on the program's call stack outside of the intended data structure, which is usually a fixed-length buffer. Stack buffer overflow bugs are caused when a program writes more data to a buffer located on the stack than what is actually allocated for that buffer. This almost always results in corruption of adjacent data on the stack, which could lead to program crashes, incorrect operation, or security issues.

Typically, buffer overflow protection modifies the organization of stack-allocated data so it includes a canary value that, when destroyed by a stack buffer overflow, shows that a buffer preceding it in memory has been overflowed. By verifying the canary value, execution of the affected program can be terminated, preventing it from misbehaving or from allowing an attacker to take control over it. Other buffer overflow protection techniques include bounds checking, which checks accesses to each allocated block of memory so they cannot go beyond the actually allocated space, and tagging, which ensures that memory allocated for storing data cannot contain executable code.

Overfilling a buffer allocated on the stack is more likely to influence program execution than overfilling a buffer on the heap because the stack contains the return addresses for all active function calls. However, similar implementation-specific protections also exist against heap-based overflows.

There are several implementations of buffer overflow protection, including those for the GNU Compiler Collection, LLVM, Microsoft Visual Studio, and other compilers.
Overview
Main article: Stack buffer overflow

A stack buffer overflow occurs when a program writes to a memory address on the program's call stack outside of the intended data structure, which is usually a fixed-length buffer. Stack buffer overflow bugs are caused when a program writes more data to a buffer located on the stack than what is actually allocated for that buffer. This almost always results in corruption of adjacent data on the stack, and in cases where the overflow was triggered by mistake, will often cause the program to crash or operate incorrectly. Stack buffer overflow is a type of the more general programming malfunction known as buffer overflow (or buffer overrun). Overfilling a buffer on the stack is more likely to derail program execution than overfilling a buffer on the heap because the stack contains the return addresses for all active function calls.[1]

Stack buffer overflow can be caused deliberately as part of an attack known as stack smashing. If the affected program is running with special privileges, or if it accepts data from untrusted network hosts (for example, a public webserver), then the bug is a potential security vulnerability that allows an attacker to inject executable code into the running program and take control of the process. This is one of the oldest and more reliable methods for attackers to gain unauthorized access to a computer.[2]

Typically, buffer overflow protection modifies the organization of data in the stack frame of a function call to include a "canary" value that, when destroyed, shows that a buffer preceding it in memory has been overflowed. This provides the benefit of preventing an entire class of attacks. According to some researchers,[3] the performance impact of these techniques is negligible.

Stack-smashing protection is unable to protect against certain forms of attack. For example, it cannot protect against buffer overflows in the heap. There is no sane way to alter the layout of data within a structure; structures are expected to be the same between modules, especially with shared libraries. Any data in a structure after a buffer is impossible to protect with canaries; thus, programmers must be very careful about how they organize their variables and use their structures.
Canaries

Canaries or canary words are known values that are placed between a buffer and control data on the stack to monitor buffer overflows. When the buffer overflows, the first data to be corrupted will usually be the canary, and a failed verification of the canary data will therefore alert of an overflow, which can then be handled, for example, by invalidating the corrupted data. A canary value should not be confused with a sentinel value.

The terminology is a reference to the historic practice of using canaries in coal mines, since they would be affected by toxic gases earlier than the miners, thus providing a biological warning system. Canaries are alternately known as cookies, which is meant to evoke the image of a "broken cookie" when the value is corrupted.

There are three types of canaries in use: terminator, random, and random XOR. Current versions of StackGuard support all three, while ProPolice supports terminator and random canaries.
Terminator canaries

Terminator canaries use the observation that most buffer overflow attacks are based on certain string operations which end at string terminators. The reaction to this observation is that the canaries are built of null terminators, CR, LF, and FF. As a result, the attacker must write a null character before writing the return address to avoid altering the canary. This prevents attacks using strcpy() and other methods that return upon copying a null character, while the undesirable result is that the canary is known. Even with the protection, an attacker could potentially overwrite the canary with its known value and control information with mismatched values, thus passing the canary check code, which is executed soon before the specific processor's return-from-call instruction.
Random canaries

Random canaries are randomly generated, usually from an entropy-gathering daemon, in order to prevent an attacker from knowing their value. Usually, it is not logically possible or plausible to read the canary for exploiting; the canary is a secure value known only by those who need to know it—the buffer overflow protection code in this case.

Normally, a random canary is generated at program initialization, and stored in a global variable. This variable is usually padded by unmapped pages so that attempting to read it using any kinds of tricks that exploit bugs to read off RAM cause a segmentation fault, terminating the program. It may still be possible to read the canary if the attacker knows where it is or can get the program to read from the stack.
Random XOR canaries

Random XOR canaries are random canaries that are XOR-scrambled using all or part of the control data. In this way, once the canary or the control data is clobbered, the canary value is wrong.

Random XOR canaries have the same vulnerabilities as random canaries, except that the "read from stack" method of getting the canary is a bit more complicated. The attacker must get the canary, the algorithm, and the control data in order to re-generate the original canary needed to spoof the protection.

In addition, random XOR canaries can protect against a certain type of attack involving overflowing a buffer in a structure into a pointer to change the pointer to point at a piece of control data. Because of the XOR encoding, the canary will be wrong if the control data or return value is changed. Because of the pointer, the control data or return value can be changed without overflowing over the canary.

Although these canaries protect the control data from being altered by clobbered pointers, they do not protect any other data or the pointers themselves. Function pointers especially are a problem here, as they can be overflowed into and can execute shellcode when called.
Bounds checking
Main article: Bounds checking

Bounds checking is a compiler-based technique that adds run-time bounds information for each allocated block of memory, and checks all pointers against those at run-time. For C and C++, bounds checking can be performed at pointer calculation time[4] or at dereference time.[5][6][7]

Implementations of this approach use either a central repository, which describes each allocated block of memory,[4][5][6] or fat pointers,[7] which contain both the pointer and additional data, describing the region that they point to.
Tagging

Tagging[8] is a compiler-based or hardware-based (requiring a tagged architecture) technique for tagging the type of a piece of data in memory, used mainly for type checking. By marking certain areas of memory as non-executable, it effectively prevents memory allocated to store data from containing executable code. Also, certain areas of memory can be marked as non-allocated, preventing buffer overflows.

Historically, tagging has been used for implementing high-level programming languages;[9] with appropriate support from the operating system, tagging can also be used to detect buffer overflows.[10] An example is the NX bit hardware feature, supported by Intel, AMD and ARM processors.
Implementations
GNU Compiler Collection (GCC)

Stack-smashing protection was first implemented by StackGuard in 1997, and published at the 1998 USENIX Security Symposium.[11] StackGuard was introduced as a set of patches to the Intel x86 backend of GCC 2.7. StackGuard was maintained for the Immunix Linux distribution from 1998 to 2003, and was extended with implementations for terminator, random and random XOR canaries. StackGuard was suggested for inclusion in GCC 3.x at the GCC 2003 Summit Proceedings,[12] but this was never achieved.

From 2001 to 2005, IBM developed GCC patches for stack-smashing protection, known as ProPolice.[13] It improved on the idea of StackGuard by placing buffers after local pointers and function arguments in the stack frame. This helped avoid the corruption of pointers, preventing access to arbitrary memory locations.

Red Hat engineers identified problems with ProPolice though, and in 2005 re-implemented stack-smashing protection for inclusion in GCC 4.1.[14][15] This work introduced the -fstack-protector flag, which protects only some vulnerable functions, and the -fstack-protector-all flag, which protects all functions whether they need it or not.[16]

In 2012, Google engineers implemented the -fstack-protector-strong flag to strike a better balance between security and performance.[17] This flag protects more kinds of vulnerable functions than -fstack-protector does, but not every function, providing better performance than -fstack-protector-all. It is available in GCC since its version 4.9.[18]

All Fedora packages are compiled with -fstack-protector since Fedora Core 5, and -fstack-protector-strong since Fedora 20.[19][20] Most packages in Ubuntu are compiled with -fstack-protector since 6.10.[21] Every Arch Linux package is compiled with -fstack-protector since 2011.[22] All Arch Linux packages built since 4 May 2014 use -fstack-protector-strong.[23] Stack protection is only used for some packages in Debian,[24] and only for the FreeBSD base system since 8.0.[25] Stack protection is standard in certain operating systems, including OpenBSD,[26] Hardened Gentoo[27] and DragonFly BSD[citation needed].

StackGuard and ProPolice cannot protect against overflows in automatically allocated structures that overflow into function pointers. ProPolice at least will rearrange the allocation order to get such structures allocated before function pointers. A separate mechanism for pointer protection was proposed in PointGuard[28] and is available on Microsoft Windows.[29]
Microsoft Visual Studio

The compiler suite from Microsoft implements buffer overflow protection since version 2003 through the /GS command-line switch, which is enabled by default since version 2005.[30] Using /GS- disables the protection.
IBM Compiler

Stack-smashing protection can be turned on by the compiler flag -qstackprotect.[31]
Clang/LLVM

Clang supports the same -fstack-protector options as GCC[32] and a stronger "safe stack" (-fsanitize=safe-stack) system with similarly low performance impact.[33] Clang also has three buffer overflow detectors, namely AddressSanitizer (-fsanitize=address),[6] UBSan (-fsanitize=bounds),[34] and the unofficial SafeCode (last updated for LLVM 3.0).[35]

These systems have different tradeoffs in terms of performance penalty, memory overhead, and classes of detected bugs. Stack protection is standard in certain operating systems, including OpenBSD.[36]
Intel Compiler

Intel's C and C++ compiler supports stack-smashing protection with options similar to those provided by GCC and Microsoft Visual Studio.[37]
Fail-Safe C

Fail-Safe C[7] is an open-source memory-safe ANSI C compiler that performs bounds checking based on fat pointers and object-oriented memory access.[38]
StackGhost (hardware-based)

Invented by Mike Frantzen, StackGhost is a simple tweak to the register window spill/fill routines which makes buffer overflows much more difficult to exploit. It uses a unique hardware feature of the Sun Microsystems SPARC architecture (that being: deferred on-stack in-frame register window spill/fill) to detect modifications of return pointers (a common way for an exploit to hijack execution paths) transparently, automatically protecting all applications without requiring binary or source modifications. The performance impact is negligible, less than one percent. The resulting gdb issues were resolved by Mark Kettenis two years later, allowing enabling of the feature. Following this event, the StackGhost code was integrated (and optimized) into OpenBSD/SPARC.
A canary example

Normal buffer allocation for x86 architectures and other similar architectures is shown in the buffer overflow entry. Here, we will show the modified process as it pertains to StackGuard.

When a function is called, a stack frame is created. A stack frame is built from the end of memory to the beginning; and each stack frame is placed on the top of the stack, closest to the beginning of memory. Thus, running off the end of a piece of data in a stack frame alters data previously entered into the stack frame; and running off the end of a stack frame places data into the previous stack frame. A typical stack frame may look as below, having a return address (RETA) placed first, followed by other control information (CTLI).

(CTLI)(RETA) 

In C, a function may contain many different per-call data structures. Each piece of data created on call is placed in the stack frame in order, and is thus ordered from the end to the beginning of memory. Below is a hypothetical function and its stack frame.

int foo() {
  int a;             /* integer */
  int *b;            /* pointer to integer */
  char c[10];        /* character arrays */
  char d[3];

  b = &a;            /* initialize b to point to location of a */
  strcpy(c,get_c()); /* get c from somewhere, write it to c */
  *b = 5;            /* the data at the point in memory b indicates is set to 5 */
  strcpy(d,get_d());
  return *b;         /* read from b and pass it to the caller */
}

(d..)(c.........)(b...)(a...)(CTLI)(RETA)

In this hypothetical situation, if more than ten bytes are written to the array c, or more than 13 to the character array d, the excess will overflow into integer pointer b, then into integer a, then into the control information, and finally the return address. By overwriting b, the pointer is made to reference any position in memory, causing a read from an arbitrary address. By overwriting RETA, the function can be made to execute other code (when it attempts to return), either existing functions (ret2libc) or code written into the stack during the overflow.

In a nutshell, poor handling of c and d, such as the unbounded strcpy() calls above, may allow an attacker to control a program by influencing the values assigned to c and d directly. The goal of buffer overflow protection is to detect this issue in the least intrusive way possible. This is done by removing what can be out of harms way and placing a sort of tripwire, or canary, after the buffer.

Buffer overflow protection is implemented as a change to the compiler. As such, it is possible for the protection to alter the structure of the data on the stack frame. This is exactly the case in systems such as ProPolice. The above function's automatic variables are rearranged more safely: arrays c and d are allocated first in the stack frame, which places integer a and integer pointer b before them in memory. So the stack frame becomes

(b...)(a...)(d..)(c.........)(CTLI)(RETA)

As it is impossible to move CTLI or RETA without breaking the produced code, another tactic is employed. An extra piece of information, called a "canary" (CNRY), is placed after the buffers in the stack frame. When the buffers overflow, the canary value is changed. Thus, to effectively attack the program, an attacker must leave definite indication of his attack. The stack frame is

(b...)(a...)(d..)(c.........)(CNRY)(CTLI)(RETA)

At the end of every function there is an instruction which continues execution from the memory address indicated by RETA. Before this instruction is executed, a check of CNRY ensures it has not been altered. If the value of CNRY fails the test, program execution is ended immediately. In essence, both deliberate attacks and inadvertent programming bugs result in a program abort.

The canary technique adds a few instructions of overhead for every function call with an automatic array, immediately before all dynamic buffer allocation and after dynamic buffer deallocation. The overhead generated in this technique is not significant. It does work, though, unless the canary remains unchanged. If the attacker knows that it's there, and can determine the value of the canary, they may simply copy over it with itself. This is usually difficult to arrange intentionally, and highly improbable in unintentional situations.

The position of the canary is implementation specific, but it is always between the buffers and the protected data. Varied positions and lengths have varied benefits.
See also

    iconComputer programming portal

    Sentinel value (which is not to be confused with a canary value)
    Control-flow integrity
    Address space layout randomization
    Executable space protection
    Memory debugger
    Static code analysis

References

Fithen, William L.; Seacord, Robert (2007-03-27). "VT-MB. Violation of Memory Bounds". US CERT.
Levy, Elias (1996-11-08). "Smashing The Stack for Fun and Profit". Phrack. 7 (49): 14.
"Buffer Overflows: Attacks and Defenses for the Vulnerability of the Decade*" (PDF). Archived from the original (PDF) on 2013-03-09.
"Bounds Checking for C". Doc.ic.ac.uk. Archived from the original on 2016-03-26. Retrieved 2014-04-27.
"SAFECode: Secure Virtual Architecture". Sva.cs.illinois.edu. 2009-08-12. Retrieved 2014-04-27.
"google/sanitizers". 19 June 2021.
"Fail-Safe C: Top Page". Staff.aist.go.jp. 2013-05-07. Archived from the original on 2016-07-07. Retrieved 2014-04-27.
"Tuesday, April 05, 2005" (PDF). Feustel.us. Archived from the original (PDF) on June 23, 2016. Retrieved 2016-09-17.
Steenkiste, Peter; Hennessy, John (1987). "Tags and type checking in LISP: hardware and software approaches". ACM Sigops Operating Systems Review. ACM. 21 (4): 50–59. doi:10.1145/36204.36183.
"ClearPath Enterprise Servers MCP Security Overview" (PDF). Public.support.unisys.com. Archived from the original (PDF) on 2013-01-24. Retrieved 2014-04-27.
"Papers - 7th USENIX Security Symposium, 1998". Usenix.org. 2002-04-12. Retrieved 2014-04-27.
"Proceedings of the GCC Developers Summit" (PDF). May 2003. Archived from the original on 2004-07-15. Retrieved 2016-09-17.
"GCC extension for protecting applications from stack-smashing attacks". Research.ibm.com. Retrieved 2014-04-27.
"GCC 4.1 Release Series — Changes, New Features, and Fixes - GNU Project - Free Software Foundation (FSF)". Gcc.gnu.org. Retrieved 2014-04-27.
"Richard Henderson - [rfc] reimplementation of ibm stack-smashing protector". Gcc.gnu.org. Retrieved 2014-04-27.
"Optimize Options - Using the GNU Compiler Collection (GCC)". Gcc.gnu.org. Retrieved 2014-04-27.
"Han Shen(ææ) - [PATCH] Add a new option "-fstack-protector-strong" (patch / doc inside)". Gcc.gnu.org. 2012-06-14. Retrieved 2014-04-27.
Edge, Jake (February 5, 2014). ""Strong" stack protection for GCC". Linux Weekly News. Retrieved 28 November 2014. "It has made its way into GCC 4.9"
"Security Features". FedoraProject. 2013-12-11. Retrieved 2014-04-27.
"#1128 (switching from "-fstack-protector" to "-fstack-protector-strong" in Fedora 20) – FESCo". Fedorahosted.org. Retrieved 2014-04-27.
"Security/Features - Ubuntu Wiki". Wiki.ubuntu.com. Retrieved 2014-04-27.
"FS#18864 : Consider enabling GCC's stack-smashing protection (ProPolice, SSP) for all packages". Bugs.archlinux.org. Retrieved 2014-04-27.
"svntogit/packages.git - Git clone of the 'packages' repository".
"Debian Security Hardening Statistics". Outflux.net. Retrieved 2014-04-27.
"FreeBSD 8.0-RELEASE Release Notes". Freebsd.org. 2013-11-13. Retrieved 2014-04-27.
"OpenBSD's gcc-local(1) manual page". "gcc comes with the ProPolice stack protection extension, which is enabled by default."
"Hardened/Toolchain - Gentoo Wiki". 2016-07-31. "The Gentoo hardened GCC switches on the stack protector by default unless explicitly requested not to."
"12th USENIX Security Symposium — Technical Paper".
"MSDN Blogs – Get the latest information, insights, announcements, and news from Microsoft experts and developers in the MSDN blogs".
"/GS (Buffer Security Check) (C++)". msdn.microsoft.com. Retrieved 2014-04-27.
"qstackprotect". Publib.boulder.ibm.com. Retrieved 2014-04-27.
"Clang mailing list". Clang.llvm.org. Retrieved 2022-11-16.
"SafeStack — Clang 17.0.0git documentation". clang.llvm.org.
"Clang Compiler User's Manual — Clang 3.5 documentation". Clang.llvm.org. Retrieved 2014-04-27.
"SAFECode". Safecode.cs.illinois.edu. Retrieved 2014-04-27.
"OpenBSD's clang-local(1) manual page". "clang comes with stack protection enabled by default, equivalent to the -fstack-protector-strong option on other systems."
"User and Reference Guide for the Intel C++ Compiler 15.0: fstack-security-check, GS". software.intel.com. Retrieved 2015-02-13.

    "thesis.dvi" (PDF). Staff.aist.go.jp. Retrieved 2016-09-17.

External links

    The GCC 2003 Summit Proceedings (PDF)
    Smashing the Stack for Fun and Profit by Aleph One
    ProPolice official home
    Immunix StackGuard Homepage
    Original StackGuard paper in USENIX Security 1998
    StackGhost: Hardware Facilitated Stack Protection
    FreeBSD 5.4 and 6.2 propolice implementation
    Four different tricks to bypass StackShield and StackGuard protection
    Stack Smashing Protector

Categories:

    Software bugsComputer security exploits