.data
input_msg1: .asciiz "Enter first number"
input_msg2: .asciiz "Enter second number"
output_msg1: .asciiz "The Maximum is :"
output_msg2: .asciiz "The Minimum is :"

.text
main:
la $a0,input_msg1
li $v0,4
syscall
li $v0,6
syscall
mov.s $f1,$f0
la $a0,input_msg2
li $v0,4
syscall
li $v0,6
syscall
mov.s $f2,$f0
c.lt.s $f1,$f2 # Check if $f1>=$f2
bc1f ifblock # if flag not set, f1 maximum
mov.s $f4,$f2 # Else, $f2 is maximum
beq $t0,0,exit
ifblock:
	mov.s $f4,$f1
exit:
	# Display the Max
	la $a0,output_msg1
	li $v0,4
	syscall
	mov.s $f12,$f4
	li $v0,2
	syscall
	li $v0,10
