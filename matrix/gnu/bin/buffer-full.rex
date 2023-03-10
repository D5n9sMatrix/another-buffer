/*
Another Sample Program
Here’s a program that shows how to build menus and call subroutines based on user input. This pro-
gram is a fragment of a real production program, slimmed down and simplified for clarity. The script
illustrates several instructions, including do and select. It also provides another example of how to
invoke internal subroutines.
The basic idea of the program is that it displays a menu of transaction options to the user. The user picks
which transaction to execute. The program then executes that transaction and returns to the user with
the menu. Here is how it starts. The program clears the screen and displays a menu of options to the
user that looks like this:
*/

/*
Based on the user’s input, the program then calls the appropriate internal subroutine to perform an
Insert, Update, or Delete transaction. (In the example, these routines are “dummied out” and all each
really does is display a message that the subroutine was entered). The menu reappears until the user
finally exits by entering the menu option ‘x’.
Here’s the complete program:
*/

/*
MENU:
This program display a menu and performs updates based
on the transaction the user selects.*/

/* clear the screen (Windows only) */
tran_type = ""
do while tran_type \= "X"
/* do until user enters ‘X’ */
say
say "Select the transation type by abbreviation:"
say
say "Insert = I" 
say "Update = U"
say "Delete = D"
say 
Exit = "X"
say
say "Your choice => "
pull tran_type .
select
    when tran_type = "I" then
say "insert_routine"
    when tran_type = "U" then
say "update_routine"
    when tran_type = "D" then
say "delete_routine"
    when tran_type = "X" then do
say
   say "Bye!"
end
   otherwise
say
say "You entered invalid transaction type:" tran_type
say "Press <ENTER> to reenter the transaction type."
pull parse 
end
end
exit 0
/* INSERT_ROUTINE goes here
INSERT_ROUTINE: procedure*/
say "Insert Routine was executed"
return 0
/* UDPATE_ROUTINE goes here
UPDATE_ROUTINE: procedure*/
