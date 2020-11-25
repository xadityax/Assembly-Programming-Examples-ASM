.data
line: .asciiz "\n"
print_str: .asciiz "value of $s0: "

.text 

main:
li $a0,10
la $a1, print_str 
la $a2, line
jal increase_the_value 
jal print_value 
li $v0,10 
syscall


increase_the_value:
addi $sp,$sp,-8 
sw $a0,($sp) 
sw $ra,4($sp) 
addi $a0,$a0,10
jal print_value 
lw $a0,($sp) # restore the value of $a0, main function should get old value of $a0
lw $ra,4($sp) 
addi $sp,$sp,8 
jr $ra


print_value:
addi $sp,$sp,-4 # since $a0 will be used to print the string, its original value would be lost
sw $a0,($sp) 
move $a0,$a1 
li $v0,4 
syscall
lw $a0,($sp) 
li $v0,1 
syscall
move $a0,$a2 
li $v0,4 
syscall
lw $a0,($sp) 
addi $sp,$sp,4
jr $ra