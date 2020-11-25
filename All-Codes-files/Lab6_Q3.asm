.data
ask_type: .asciiz "Triangle 1 Square 0\n"
how_many: asciiz "How many lines\n"
line: .asciiz "\n"
print_str: .asciiz "value of $s0: \n"

.text 
main:
la $a0,ask_type
li $v0,4
syscall
la $a0,how_many
syscall
li $v0,5
move $a0,$v0
bgt $t0,$0,triangle_print
beq $t0,$0,square_print
li $v0,10 
syscall


triangle_print:
addi #sp,$sp,-8
sw $a0,0($sp)
sw $ra,4($sp)
li $t0,1

jr $ra

L1:
addi $a0,$a0,-1
jal fact
lw $a0,0($sp)
lw $ra,4($sp)
addi $sp,$sp,8
mul $v0,$v0,$a0
jr $ra

