/*
The when clause where the user enters ‘x’ or ‘X’ encloses its multiple instructions within a do-end pair.
The otherwise clause handles the case where the user inputs an invalid character. The final end in the
code concludes the select instruction.
Remember that the logic of the select statement is that the first condition that evaluates to TRUE is the
branch that executes. In the preceding code, this means that the program will call the proper subroutine
based on the transaction code the user enters.
Following the select instruction, the code for the main routine or driver ends with an exit 0 statement:
*/
exit 0