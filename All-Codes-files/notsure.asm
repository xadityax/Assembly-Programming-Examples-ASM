.data
myStr: .space 6
newl: .ascii '\n'
eod: .ascii '\0'
palin

.text

main:
lb $t4, newl
li $v0, 8
la $a0, myStr
li $a1, 6
syscall
add $t2,$a0,$zero

getEOString:
lb $t3, 0($t2)
addi $t2,$t2,1
beq $t3,$t4,khatam
bne $t3,$zero,getEOString

khatam:
addi $t2,$t2,-2
add $t1,$a0,$zero

checkpalin:
bge $t1,$t2,palin
lb $t3, 0($t2)
lb $t5, 0($t1)
bne $t3,$t5,notpalin
addi $t2,$t2,-1
addi $t1,$t1,1
j checkpalin

palin:
la $a0,