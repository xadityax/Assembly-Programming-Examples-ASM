#2017B1A71075H
#Aditya Agarwal
#9079635401
#f20171075@hyderabad.bits-pilani.ac.in

.data
space: .asciiz " "
msg1: .asciiz "Max Height is\n"
msg2: .asciiz "Inside inorder\n"
msg3: .asciiz "Empty tree\n"
output_msg1: .asciiz "The answer is :"
inp: .asciiz "Initializing\n"
list: .word 1, 2

.text

main:
	la $a0,inp
	li $v0,4 # INIT MSG
	syscall
	li $s0,0 # s0 always points to the root node of binary tree, initially NULL/0 
	li $t4,0
get_input: 
	li $v0,5
	syscall
	beq $v0,$zero,break_of_loop
	addi $t4,$t4,1
	move $a0,$v0 # a0 = number to be inserted
	move $a1,$s0 # a1 = ptr to the root, initially NULL
	jal insert
	move $s0,$v0 # v0 adress to the root, storing it in $s0
	j get_input

break_of_loop:
	ble $t4,$0,zero_height
	move $a0,$s0
	move $a1,$0 # a1 cur_depth
	move $a2,$0 # a2 max_depth
	jal inorder_traversal # inorder traversal - $a0 holds address of the root
	move $t0,$v0
	la $a0,msg1
	li $v0,4
	syscall
	la $a3,list
	lw $t0,($a3)
	move $a0,$t0
	li $v0,1
	syscall
	li $v0,10 
	syscall

zero_height:
	la $a0,msg3
	li $v0,4
	syscall
	li $a0,0
	li $v0,1
	syscall
	li $v0,10
	syscall

insert:
	bne $a1,$zero,not_base_case # check for base case i.e. root==NULL
	move $t0,$a0 # base case
	li $a0,12
	li $v0,9
	syscall
	sw $t0,0($v0) # root->val at address v0
	sw $zero,4($v0) # root->left at v0+4
	sw $zero,8($v0) # root->right at v0+8
	move $a0,$t0 # reload
	jr $ra 

not_base_case:
	addi $sp,$sp,-12
	sw $ra,0($sp)
	sw $a1,4($sp)
	sw $s0,8($sp) # currently same as a1
	lw $t1,0($a1) # load value at root into t1
	ble $t1,$a0,right # if root < current, put current on right

left:
	addi $a1,$a1,4 # left node pointer at 4($a1) : after this it’s at 0($a1)
	move $s0,$a1
	lw $a1,($a1) # now we have the pointer value – may be null
	jal insert # return value of this function is in $v0, which holds the address of the newly created child
	j returnNonBase

right:
	addi $a1,$a1,8 # right node pointer 
	move $s0,$a1
	lw $a1,($a1) # now we have the pointer value – may be null
	jal insert 
	j returnNonBase

returnNonBase:
	sw $v0,($s0) # null value is being updated with the address returned
	lw $ra,($sp) 
	lw $a1,4($sp) 
	lw $s0,8($sp)
	addi $sp,$sp,12 
	move $v0,$a1
	jr $ra

inorder_traversal: # a0 is argument, holds address of the root initially
	beq $a0,$zero,return_inorder
	addi $sp,$sp,-20
	sw $ra,($sp)  # return address
	sw $a0,4($sp) # traverse left, then print the middle element then traverse right
	sw $s0,8($sp) # root
	sw $a1,12($sp) # store args a1
	sw $a2,16($sp) # store args a2
	move $s0,$a0
	lw $a0,4($s0)
	lw $a1,12($sp)
	lw $a2,16($sp)
	addi $a1,$a1,1
	#debug to check if correct inorder traversal
	# move $t2,$a0
	#la $a0,msg2
	#li $v0,4
	#syscall
	#move $a0,$a1
	#li $v0,1
	#syscall
	#move $a0,$t2
	## debug end
	la $a3,list
	lw $t5,($a3)
	blt $a1,$t5,no_change
	sw $a1,($a3)
	move $a2,$a1
	sw $a2,16($sp)
	no_change:
	jal inorder_traversal
	lw $a0,($s0)
	## debug to check if correct word load
	#li $v0,1
	#syscall
	## debug end 
	lw $a0,8($s0)
	jal inorder_traversal
	## reload
	lw $ra,($sp) 
	lw $a0,4($sp) 
	lw $s0,8($sp)
	lw $a1,12($sp)
	lw $a2,16($sp)
	move $v0,$a2
	addi $sp,$sp,20
	
return_inorder:
	jr $ra