.data 
list: .word 17, 5, 92, 87, 41, 10, 23, 55, 72, 36 
inp: .asciiz "INIT\n"
space: .asciiz " " 

.text  
main: 
la $a0,inp
li $v0,4
syscall
li $s7,10 # size
addi $s3,$s7,-1 # size-1
la $a1,list # address of start
loop:
	li $s6,0
	move $t0,$a1
	loop_inner:
		lw $t1,($t0) # load current value from addr
		lw $t3,4($t0) # load next value from addr
		swap:
			ble $t1,$t3,no_swap
			sw $t3,($t0)
			sw $t1,4($t0)
		no_swap:
			addi $t0,$t0,4
			addi $s6,$s6,1
			blt $s6,$s3,loop_inner
	addi $s3,$s3,-1
	bgt $s3,$zero,loop
reload_base:
	move $t0,$a1
	li $s6,0
	move $s3,$s7
print:
	lw $t1,($t0)
	move $a0,$t1
	li $v0,1
	syscall
	la $a0,inp
	li $v0,4
	syscall
	addi $s6,$s6,1
	addi $t0,$t0,4
	blt $s6,$s3,print
end:
	li $v0,10
	syscall


