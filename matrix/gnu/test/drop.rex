/*
This delimits the code of the main routine from that of the routines that follow it and also sends a return
code of 0 to the environment when the script ends. An exit instruction is required to separate the code
of the main routine from the subroutines or functions that follow it.
The three update routines contain no real code. Each just displays a message that it ran. This allows the
user to verify that the script is working. These subroutines cannot access any variables within the main
routine, because they have the procedure instruction, and no variables are passed into them. Each ends
with a return 0 instruction:
*/
return 0
