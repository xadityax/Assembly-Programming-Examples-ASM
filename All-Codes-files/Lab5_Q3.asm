.data

str : .space 6 
rev_str : .space 6 
newLine : .asciiz "\n"

.text 

main :
la $a0,str 	
move $t0,$a0 # base address in $t0
li $a1,6
li $v0,8 # read string of length 5 
syscall
la $t1,rev_str	
move $t4,$t1 # base address of reverse string in $t4
li $t2,4 # predefined length
add $t3,$t1,$t2	# address of last character
loop:
	blt  $t3,$t4,exit
	lb $t5, ($t0)
	sb $t5, ($t3)
	add $t0,$t0,1
	sub $t3,$t3,1
	j loop
exit:
	la $a0, rev_str	# print reverse string
	li $v0,4
	syscall
	li $v0,10 	#exit
	syscall