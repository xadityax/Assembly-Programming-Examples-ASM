.data #variable declaration follow this line

myMsg: .asciiz "Hello Enter a number." # string declaration
myMsg2: .asciiz "Enter second number." # string declaration
myMsg3: .asciiz "Sum is  " # string declaration

.text
main:
li $v0,6 #input float
syscall
mov.s $f11,$f0
li $v0,6
syscall
mov.s $f10,$f0
#add.s $f10,$f11,$f10
#sub.s $f10,$f11,$f10
neg.s $f10,$f10
add.s $f10,$f11,$f10
mov.s $f12,$f10
li $v0,2
syscall
li $v0,10
syscall

# also subtract using sub.s and neg.s