/*
When the Rexx interpreter does not recognize a statement as part of the Rexx language, it assumes that it
is an operating system command and passes it to the operating system for execution. Since there is no
such command as cls in the Rexx language, the interpreter passes the string cls to the operating sys-
tem for execution as an operating system command.
*/

/*
cls is the Windows command to “clear the screen,” so what this statement does is send a command to
Windows to clear the display screen. Of course, this statement makes this program operating-system-
dependent. To run this program under Linux or Unix, this statement should contain the equivalent com-
mand to clear the screen under these operating systems, which is clear:
*/

/* Next in the program, a series of say commands paints the menu on the user’s screen:*/
say
say 'Select the transation type by abbreviation:'
say
say 'Insert = I'
say 'Update = U'
say 'Delete = D'
say 
Exit = 'X'
say
say 'Your choice =>'

