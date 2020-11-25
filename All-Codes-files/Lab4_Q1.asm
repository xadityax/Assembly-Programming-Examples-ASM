.data #variable declaration follow this line
myMsg: .asciiz "Hello, MAX IS :  " 

.text

main:
li $v0,5
syscall
move $t0,$v0
li $v0,5
syscall
move $t1,$v0
bge $t0,$t1,ifblock # Check if $t0>=$t1, go to if
move $t2,$t1 # else, $t1 is maximum, we swap
blt $t0,$t1,exit #move to seq execution

ifblock:
move $t2,$t0 

exit:
la $a0,myMsg
li $v0,4
syscall
move $a0,$t2
li $v0,1
syscall
li $v0,10
syscall
