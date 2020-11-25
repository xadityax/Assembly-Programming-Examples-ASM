.data
line: .asciiz "\n"
print_str: .asciiz "value of $s0: "

.text 
main:
li $a0,5
la $a1, print_str 
la $a2, line
jal fact 
move $a0,$v0
li $v0,1
syscall
li $v0,10 
syscall


fact:
addi $sp,$sp,-8 
sw $a0,($sp) 
sw $ra,4($sp)
li $t0,1
bgt $a0,$t0,L1 # n>1
addi $v0,$0,1
addi $sp,$sp,8
jr $ra

L1:
addi $a0,$a0,-1
jal fact
lw $a0,0($sp)
lw $ra,4($sp)
addi $sp,$sp,8
mul $v0,$v0,$a0
jr $ra

