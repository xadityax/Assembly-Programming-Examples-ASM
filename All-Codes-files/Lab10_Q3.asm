.data 
array: .word 5, 4, 3, 2, 1 # an array of words 
size: .word 5  
inp: .asciiz "INIT\n"
space: .asciiz " "
inp2: .asciiz "In while\n"

.text
main:
la $a0,inp
li $v0,4
syscall
la $a1,array
lw $s0,size
addi $s1,$s0,-1
li $t0,1
addi $a1,$a1,4
outer_for:
	move $t1,$t0 # t1 is d
	move $a2,$a1 # a2 is addr of d
	inner_while:
		lw $t2,0($a2)
		lw $t3,-4($a2)
		bge $t2,$t3,out_of_while
		la $a0,inp2
		li $v0,4
		syscall
		sw $t3,0($a2)
		sw $t2,-4($a2)
		addi $t1,$t1,-1
		addi $a2,$a2,-4
		bgt $t1,$0,inner_while
	out_of_while:
	addi $t0,$t0,1
	addi $a1,$a1,4
	ble $t0,$s1,outer_for
reload_base:
	la $a2,array
	li $t0,0
print_arr:
	lw $a0,0($a2)
	li $v0,1
	syscall
	la $a0,inp
	li $v0,4
	syscall
	addi $t0,$t0,1
	addi $a2,$a2,4
	ble $t0,$s1,print_arr
end:
	li $v0,10
	syscall