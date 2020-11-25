# CHECK IF INPUT STRING PALINDROME
# FIRST KEEP A .SPACE VARIABLE WITH SIZE=LENGTH+1 OF YOUR INPUT STRING
# LOAD THIS ADDRESS INTO $a0 SINCE WE WILL TAKE INPUT IN IT
# LOAD BUFFER SIZE INTO $a1 which is same as space in .space variable
# store base address in temp register
# keep incrementing base address and checking for \0 and \n characters
# when they are encountered, decrement to store address of last character
# move the front and back pointer till front>=back or characters unequal

.data

theStr : .space 6 # space of 6 bytes
isPal : .asciiz "Palindrome" 
notPal : .asciiz "Not a Palindrome" 
newLine : .asciiz "\n"

.text 
main :
lb $t4, newLine
li $v0, 8 
la $a0, theStr # base address of theStr
li $a1, 6 # length of string 
syscall
add $t2,$a0,$zero # load base addr

slen : 
lb $t3, ($t2) # load current byte
addi $t2,$t2, 1
beq $t3,$t4, EOS # '\n'
bne $t3,$zero, slen # '\0'

EOS :
add $t1,$a0,$zero # reload base
addi $t2,$t2,-2 # -2 because moved one after '\0'or'\n'

test_loop :
bge $t1, $t2, is_palin 
lb $t3, 0($t1) # char at lower ptr 
lb $t4, 0($t2) # char at upper ptr 
bne $t3, $t4, not_palin 
addi $t1, $t1, 1 
addi $t2, $t2, -1 
j test_loop 

is_palin :
li $v0, 4
la $a0, isPal 
syscall
j exit 

not_palin :
li $v0, 4
la $a0, notPal 
syscall

exit :
li $v0,10 
syscall