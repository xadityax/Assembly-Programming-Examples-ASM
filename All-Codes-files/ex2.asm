.data #variable declaration follow this line
# sample string variable declaration – not used in first exercise.

myMsg: .asciiz "Hello Enter a number." # string declaration
newl: .asciiz "\n"
# .asciiz directive makes string null terminated

.text #instructions follow this line

main:
li $a0,10
li $v0,1
syscall
la $a0, newl
li $v0,4
syscall
la $a0, myMsg
li $v0,4
syscall
li $v0,10 
syscall