.data #variable declaration follow this line

myMsg: .asciiz "Hello Enter a number." # string declaration
myMsg2: .asciiz "Enter second number." # string declaration
myMsg3: .asciiz "Sum is  " 			   # string declaration
myMsg4: .asciiz "Difference is  "      # string declaration
newl: .asciiz "\n"

.text 

#User Input - 4294967295 , Input 2 - 4294967295
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

#Sum we get is -2, Difference we get is 0