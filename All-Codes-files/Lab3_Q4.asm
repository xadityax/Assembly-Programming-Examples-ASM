.data
str0: .asciiz "\nMul:"
str1: .asciiz "\nDiv:"
w1: .word 300
w2: .word 7

.text
main:
lw $t0, w1
lw $t1, w2
la $a0, str0
li $v0, 4
syscall
mul $a0, $t0, $t1
li $v0,1 # INTEGER MULTIPLICATION OUTPUT
syscall
la $a0, str1
li $v0, 4
syscall
div $a0, $t0, $t1 #INTEGER DIV OUTPUT
li $v0,1
syscall
div $t0, $t1
# MODULO 
#mfhi $a0 
# QUOTIENT
mflo $a0
li $v0,1
syscall
li $v0,10
syscall