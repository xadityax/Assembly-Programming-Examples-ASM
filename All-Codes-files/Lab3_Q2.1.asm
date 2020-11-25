.data
val1:
.double 0.001
.text
main:
l.d $f12, val1
li $v0,3
syscall
li $v0, 7
syscall
mov.d $f12, $f0
li $v0,3
syscall
li $v0,10
syscall