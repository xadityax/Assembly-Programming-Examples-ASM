.data #variable declaration follow this line

myMsg: .asciiz "Hello Enter a number." # string declaration
myMsg2: .asciiz "Enter second number." # string declaration
myMsg3: .asciiz "Sum is  " 			   # string declaration
myMsg4: .asciiz "Difference is  "      # string declaration
newl: .asciiz "\n"                     # .asciiz directive makes string null terminated

.text #instructions follow this line

main:
li $v0,4
la $a0,myMsg
syscall
li $v0,5
syscall
move $t0,$v0
li $v0,4
la $a0,myMsg2
syscall
li $v0,5
syscall
move $t1,$v0
move $t3,$t1
add $t1,$t1,$t0
sub $t0,$t0,$t3
la $a0,myMsg3
li $v0,4
syscall
move $a0,$t1
li $v0,1 
syscall
la $a0,myMsg4
li $v0,4
syscall
move $a0,$t0
li $v0,1
syscall
li $v0,10
syscall