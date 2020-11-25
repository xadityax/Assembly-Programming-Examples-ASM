.data
myMsg : .asciiz "IT IS EVEN"
myMsg2 : .asciiz "IT IS ODD"

.text

main:
li $v0,5
syscall
move $t0,$v0
li $t1,2
div $t0,$t1
mfhi $t0
beqz $t0,ifblock # if($t0%2==0) -> even
la $a0,myMsg2 # else print odd
li $v0,4
syscall
bnez $t0,exit

ifblock:
la $a0,myMsg 
li $v0,4
syscall
li $v0,10
syscall

exit:
li $v0,10
syscall