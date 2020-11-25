.data 
list: .double 17.2, 17.1, 92.2, 87.3, 41.4, 10.1, 23.2, 55.9, 72.1, 36.2
inp: .asciiz "INIT\n"
space: .asciiz " " 

.text  
main: 
la $a0,inp
li $v0,4
syscall
li $s7,10 # size of the list(sz) 
addi $s3,$s7,-1 
la $a1,list # address of start
loop:
	li $s6,0
	move $t0,$a1
	loop_inner:
		ldc1 $f10,($t0) # load current value from addr
		ldc1 $f12,8($t0) # load next value from addr
		swap:
			c.le.d $f10,$f12
			bc1t no_swap
			sdc1 $f12,($t0)
			sdc1 $f10,8($t0)
		no_swap:
			addi $t0,$t0,8
			addi $s6,$s6,1
			blt $s6,$s3,loop_inner
	addi $s3,$s3,-1
	bgt $s3,$zero,loop
reload_base:
	move $t0,$a1
	li $s6,0
	move $s3,$s7
print:
	ldc1 $f12,($t0)
	li $v0,3
	syscall
	la $a0,inp
	li $v0,4
	syscall
	addi $s6,$s6,1
	addi $t0,$t0,8
	blt $s6,$s3,print
end:
	li $v0,10
	syscall


