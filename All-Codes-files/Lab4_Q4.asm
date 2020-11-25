.data
input_msg: .asciiz "Enter a number: "
output_msg: .asciiz "The sum of first n numbers is "

.text

main:
	la $a0,input_msg
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $t3,$v0
	li $t0,0 #intialize sum=0.
	li $t1,1 #intialize count=0
loop:
	bgt $t1,$t3,exit # if count>n, exit
	add $t0,$t0,$t1 # store sum
	addi $t1,$t1,1 # increment count
	j loop
exit:
	la $a0,output_msg
	li $v0,4
	syscall
	move $a0,$t0
	li $v0,1
	syscall
	li $v0,10
	syscall