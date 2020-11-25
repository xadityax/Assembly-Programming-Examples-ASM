# min max of array
.data

str: .asciiz "How Many\n"
min_dis : .asciiz "Min is : \n" 
max_dis : .asciiz "Max is : \n" 
newLine : .asciiz "\n"
arr: .space 100

.text 

main:

la $a0,str
li $v0,4
syscall
li $v0,5
syscall
move $t0,$v0 # t0 has size of array
la $t6,arr # t6 has addr
li $t2,-1 # t2 min
li $t3,0 # t3 max
li $t4,1 # temp reg t4 with 1
loop:
	beq $t0,0,input_done # fin scanning
	li $v0,5
	syscall
	move $t1,$v0 # t1 has input
	bgt $t1,$t3,swap_max
	blt $t1,$t2,swap_min
	sw $t1,0($t6)
	add $t6,$t6,4
	sub $t0,$t0,$t4
	j loop

swap_max:
	move $t3,$t1
	sw $t1,0($t6)
	add $t6,$t6,4
	sub $t0,$t0,1
	j loop
swap_min:
	move $t2,$t1
	sw $t1,0($t6)
	add $t6,$t6,4
	sub $t0,$t0,1
	j loop

input_done:
	la $a0,min_dis
	li $v0,4
	syscall
	li $v0,1
	move $a0,$t2
	syscall
	la $a0,max_dis
	li $v0,4
	syscall
	li $v0,1
	move $a0,$t3
	syscall
	li $v0,10
	syscall


	