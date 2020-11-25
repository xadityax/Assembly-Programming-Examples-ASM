.data 
array: .word 5, 4, 3, 2, 1 # an array of words 
left: .space 24
right: .space 24
size: .word 5
inp: .asciiz "INIT\n"
space: .asciiz " "
inp3: .asciiz "In merge\n"
inp4: .asciiz "In print\n"
inp5: .asciiz "In mergesort"
fos: .asciiz "In for\n"
pstart: .asciiz "Start print\n"

.text

main:
	la $a0,inp
	li $v0,4
	syscall
	la $a0,array # a0 start addr
	la $s0,array
	li $t0,5 # t0 size
	move $t2,$a0
	mul $t0,$t0,4
	add $a1,$a0,$t0 # a1 end addr
	jal mergesort
	li $t0,5
	li $t3,1
	move $t7,$a0
	la $a0,pstart
	li $v0,4
	syscall
	move $a0,$t7
	print_arr:
		lw $a0,0($s0)
		li $v0,1
		syscall
		la $a0,inp4
		li $v0,4
		syscall
		addi $t3,$t3,1
		addi $s0,$s0,4
		ble $t3,$t0,print_arr
	end:
		li $v0,10
		syscall
merge:
	addi $a1,$a1,4
	move $t0,$a0 # changing start
	move $t1,$a1 # changing middle
	move $t2,$a0 # global start
	sub $t3,$a1,$a0
	srl $t3,$t3,2 # t3 size left
	sub $t4,$a2,$a1
	srl $t4,$t4,2 # t4 size right
	li $t5,0
	la $a2,left # copy left
	c_left:
		lw $t6,0($t0)
		sw $t6,0($a2)
		addi $t0,$t0,4
		addi $a2,$a2,4
		addi $t5,$t5,1
		blt $t5,$t3,c_left
	la $a2,right # copy right
	li $t5,0
	c_right:
		lw $t6,0($t1)
		sw $t6,0($a2)
		addi $t1,$t1,4
		addi $a2,$a2,4
		addi $t5,$t5,1
		blt $t5,$t4,c_right
	la $t0,left
	la $t1,right
	for:
		lw $s0,0($t0)
		li $v0,1
		syscall
		lw $s1,0($t1)
		bgt $s0,$s1,push_a1
		push_a0:
			addi $t0,$t0,4
			j after
		push_a1:
			sw $s1,0($t2)
			addi $t1,$t1,4
		after:
		addi $t2,$t2,4
		bgt $t0,$a1,left_done
		bgt $t1,$a2,right_done
		j for
	left_done:
		lw $a0,($t1)
		sw $a0,($t2)
		addi $t1,$t1,4
		addi $t2,$t2,4
		bgt $t1,$a2,endmerge
		j left_done
	right_done:
		lw $a0,($t0)
		sw $a0,($t2)
		addi $t0,$t0,4
		addi $t2,$t2,4
		bgt $t0,$a1,endmerge
		j right_done
endmerge:
	jr $ra
mergesort:
	addi $sp,$sp,-16
	sw $ra,0($sp) 
	sw $a0,4($sp) 
	sw $a1,8($sp)
	sub $t0,$a1,$a0 
	ble $t0,4,mergesortend # start - end <=4, 1 or 0 elements
	srl $t0,$t0,3 # find out half the total num of elements
	sll $t0,$t0,2  # half the number of elements * 4 gives mid addr offset
	add $a1,$a0,$t0 # add to start to mid addr
	sw $a1,12($sp) # store mid since recursive calls
	jal mergesort # mergesort left half
	lw $a0,12($sp) # for right half, start is mid
	lw $a1,8($sp) # end is end stored at 8sp
	jal mergesort
	lw $a0,4($sp) 
	lw $a1,12($sp) 
	lw $a2,8($sp) 
	jal merge
mergesortend:
	lw $ra,0($sp) 
	addi $sp,$sp,16 
	jr $ra # equivalent to return