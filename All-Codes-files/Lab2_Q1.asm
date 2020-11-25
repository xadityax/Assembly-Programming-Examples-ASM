.data
input_msg1: .asciiz "Enter First Number:"
input_msg2: .asciiz "Enter Second Number:"

.text
main:
la $a0,input_msg1
li $v0,4
syscall
li $v0,5
syscall
add $t0,$v0,0

la $a0,input_msg2
li $v0,4
syscall
li $v0,5
syscall
add $t1,$v0,0
add $t0,$t0,$t1
add $a0,$t0,0
li $v0,1
syscall
sub $t0,$t0,$t1
sub $t0,$t0,$t1
add $a0,$t0,0
li $v0,1
syscall
li $v0,10
syscall

# Number of temp registers used - 2 : t0,t1