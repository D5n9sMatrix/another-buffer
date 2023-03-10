#!-*- coding: utf-8 -*-
"""Python zilla"""

# Unstructured Control Instructions
# Rexx is a great language for structured programming. It supports all the constructs required and makes
# structured programming easy. But the language is powerful and flexible, and there are times when
# unstructured flow of control is necessary (or at least highly convenient). Here are the unstructured
# instructions that alter program flow in Rexx:
# InstructionUse
# do untilA form of the do instruction that implements a bottom-drive loop. Unlike do-
# while, do-until will always execute the code in the loop at least one time,
# because the condition test occurs at the bottom of the loop.
# do foreverCreates an endless loop, a loop that executes forever. This requires an unstruc-
# tured exit to terminate the loop. Code the unstructured exit by either the
# leave, signal or exit instruction.
# iterateCauses control to be passed from the current statement in the do loop to the
# bottom of the loop.
# leaveCauses an immediate exit from a do loop to the statement following the loop.
# signalUsed to trap exceptions (specific program error conditions). Can also be used to
# unconditionally transfer control to a specified label, similarly to the GOTO
# instruction in other programming languages.

# Figure 3-2 below illustrates the unstructured control constructs.
# The do until and do forever are two more forms of the do instruction. do until implements a
# bottom-driven loop. Such a loop always executes at least one time. In contrast, the do while checks the
# condition prior to entering the loop, so the loop may or may not be executed at least once. do until is
# considered unstructured and the do while is preferred. Any logic that can be encoded using do until
# can be coded using do while — you just have to think for a moment to see how to change the logic into
# a do while.
# Let’s look at the difference between do while and do until. This code will not enter the do loop to
# display the message. The do while tests the condition prior to executing the loop, so the loop never
# executes. The result in this example is that the say instruction never executes and does not display the
# message:

class Example(object):
    def __init__(self):
        self.name = 'list'
    if __name__ in ("__name__"):
        say 'Loop 1 was entered'
    elif __name__:
        say 'YES'
    elif __name__:
        say 'NO'
        
