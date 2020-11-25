.data
str0: .asciiz "\nMul:"
str1: .asciiz "\nDiv:"
w1: .word 10051
w2: .word 98712

.text
main:
lw $t0, w1
lw $t1, w2
la $a0, str0
li $v0, 4
syscall
mul $a0,$t0,$t1 # multipy ints
li $v0,1 
syscall
mtc1 $t0,$f1 # t0 - > f1
mtc1 $t1,$f2
cvt.s.w $f1,$f1 
cvt.s.w $f2,$f2 
mul.s $f12,$f1,$f2 # multiply floats
la $a0,str0
li $v0,4
syscall
li $v0,2 # display from f12
syscall
la $a0,str0
li $v0,4
syscall
cvt.w.s $f12,$f12 # back to word/int
mfc1 $t0,$f12 # CP1 to t0
move $a0,$t0
li $v0,1
syscall
la $a0,str0
li $v0,4
syscall
mov.s $f4,$f1
cvt.d.s $f4,$f4
cvt.d.s $f2,$f2 # convert to double precision
mul.d $f12,$f4,$f2
li $v0,3
syscall
cvt.w.d $f12,$f12
move
li $v0,10
syscall