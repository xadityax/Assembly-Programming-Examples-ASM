#2017B1A71075H
#Aditya Agarwal
#9079635401
#f20171075@hyderabad.bits-pilani.ac.in

.data
input_msg1: .asciiz "Enter first number\n"
input_msg2: .asciiz "Enter second number\n"
output_msg1: .asciiz "The answer is :"
val1: .double 0.01

.text
main:
la $a0,input_msg1
li $v0,4
syscall
li $v0,7
syscall
mov.d $f2,$f0  # a
la $a0,input_msg2
li $v0,4
syscall
li $v0,7
syscall
mov.d $f4,$f0 # b
l.d $f6,val1 #store 0.01 in f6
loop: 
	c.le.d $f2,$f6 #check if a <= 0.01
	bc1t exit #exit if true
	div.d $f2,$f2,$f4 # a = a/b
	j loop
exit:
mov.d $f12,$f2 # display whatever in f2
la $a0,output_msg1
li $v0,4
syscall
li $v0,3
syscall
li $v0,10
syscall