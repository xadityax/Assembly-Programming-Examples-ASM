.data
newl: .asciiz "\n"
inp: .asciiz "Please enter num studs\n"
inp2: .asciiz "Enter Roll Num, Name and CGPA consecutively\n"

.text
main:
	la $a0,inp
	li $v0,4
	syscall
	li $v0,5
	syscall
	move $t1,$v0 # t1 has N
	move $a0,$t1
	mul $a0,$a0,32
	li $v0,9
	syscall # now $v0 holds the address of first byte of 32*N bytes of free memory
	addi $t4,$v0, 0 # t4 has start of struct
	addi $t6,$v0, 0 # t6 has start of struct
	li $t2,1 # t2 is counter
	la $a0,inp2
	li $v0,4
	syscall
	
loop_array:
    bgt $t2,$t1,done_input
	li $v0,5
	syscall
	sw $v0, 0($t6)
	add $t6,$t6,4
	la $a0, 0($t6)
	li $a1,20
	li $v0,8
	syscall
	add $t6,$t6,20
	li $v0,7
	syscall
	s.d $f0, 0($t6)
	add $t6,$t6,8
	add $t2,$t2,1
	j loop_array
done_input:
	li $t2,1
print_array:
	bgt $t2,$t1,done
	lw $a0, 0($t4)
	li $v0,1
	syscall
	add $t4,$t4,4
	la $a0, 0($t4)
	li $v0,4
	syscall
	add $t4,$t4,20
	l.d $f12, 0($t4)
	li $v0,3
	syscall
	add $t4,$t4,8
	add $t2,$t2,1
	j print_array
done:
	li $v0,10
	syscall