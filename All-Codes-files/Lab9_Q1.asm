.data
space: .asciiz " "

.text 
main:
	li $s0,0 # s0 always points to the root node of binary tree, initially NULL

get_input: 
	li $v0,5
	syscall
	beq $v0,$zero,break_of_loop
	move $a0,$v0 # a0 = number to be inserted
	move $a1,$s0 # a1 = ptr to the root, initially NULL
	jal insert
	move $s0,$v0 # v0 adress to the root, storing it in $s0
	j get_input

break_of_loop:
	move $a0,$s0
	jal inorder_traversal # inorder traversal - $a0 holds address of the root
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
	addi $sp,$sp,-12 
	sw $ra,($sp) 
	sw $a0,4($sp) # traverse left, then print the middle element then traverse right
	sw $s0,8($sp)
	move $s0,$a0
	lw $a0,4($s0)
	jal inorder_traversal
	lw $a0,($s0)
	li $v0,1
	syscall 
	lw $a0,8($s0)
	jal inorder_traversal
	lw $ra,($sp) 
	lw $a0,4($sp) 
	lw $s0,8($sp)
	addi $sp,$sp,12
	
return_inorder:
	jr $ra