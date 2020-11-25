.data
val1:
.float 0.001
.text

main:
l.s $f12, val1 #load float into f12
li $v0,2 #output float
syscall
li $v0, 6 #scan
syscall
mov.s $f12, $f0
li $v0, #out float
syscall
li $v0,10
syscall