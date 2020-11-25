.data
newl: .asciiz "\n"
inp: .asciiz "Please enter array size\n"
inp2: .asciiz "Array enter\n"

.text
main:
	la $a0,inp
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $t1,$v0
	move $a0,$t1
	mul $a0,$a0,4
	li $v0,9
	syscall # now $v0 holds the address of first byte of 12 bytes of free memory
	addi $t4,$v0,0
	addi $t6,$v0,0
	li $t2,1
	la $a0,inp2
	li $v0,4
	syscall

loop_array:
    bgt $t2,$t1,done_input
	li $v0,5
	syscall
	sw $v0,0($t6)
	add $t6,$t6,4
	add $t2,$t2,1
	j loop_array

done_input:
	li $t2,1
	li $t7,0

print_array:
	bgt $t2,$t1,print_sum
	lw $a0, 0($t4)
	add $t7,$t7,$a0
	li $v0,1
	syscall
	add $t4,$t4,4
	add $t2,$t2,1
	j print_array

print_sum:
	move $a0, $t7
	li $v0,1
	syscall
	li $v0,10
	syscall
