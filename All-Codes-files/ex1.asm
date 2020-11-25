.data #variable declaration follow this line
# sample string variable declaration – not used in first exercise.
myMsg: .asciiz "Hello Enter a number." # string declaration
# .asciiz directive makes string null terminated
.text #instructions follow this line
main:
li $a0,10
li $v0,1
syscall
li $v0,10 #System call - Exit - QTSPIM to properly terminate the run
syscall