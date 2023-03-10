/*
A say instruction with no operand just displays a blank line and can be used for vertically spacing the
output on the user’s display screen.
The script displays the menu repeatedly until the user finally enters ‘x’ or ‘X’. The pull command’s
automatic translation of user input to uppercase is handy here and eliminates the need for the program-
mer to worry about the case in which the user enters a letter.
The select construct leads to a call of the proper internal routine to handle the transaction the user
selects:
*/
select
    when tran_type = 'I' then
call insert_routine
    when tran_type = 'U' then
call update_routine
    when tran_type = 'D' then
call delete_routine
    when tran_type = 'X' then do
say
    say 'Bye!'
end
    otherwise
say
say 'You entered invalid transaction type:' tran_type
say 'Press <ENTER> to reenter the transaction type.'
pull parse
end