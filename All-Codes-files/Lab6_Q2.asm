.data

nline: .asciiz "\n"
init: .asciiz "init\n"
sz: .asciiz "Size :\n"
inp: .asciiz "Enter:\n"
str: .space 10
vowels: .asciiz "aeiou"
fin_str: .space 10

.text

main:
la $a0,init
li $v0,4
syscall
la $a0,str
li $a1,10
li $v0,8
syscall
jal runloop
move $a0,$v0
li $v0,1
syscall
la $a0,fin_str
li $v0,4
syscall
li $v0,10
syscall

runloop:
	addi $sp,$sp,-4
	sw $ra,($sp)
	la $t0,str
	lb $t2,nline
	li $t7,0 # cnt of vowels 
	la $t6,fin_str
	countvowels:
		lb $t1,($t0)
		beq $t1,$t2,eos
		beq $t1,$0,eos
		la $t3,vowels
		checkifvowel:
			lb $t4,($t3)
			beq $t4,$t2,end_no_vowel
			beq $t4,$0,end_no_vowel
			bne $t1,$t4,not_vowel
			addi $t7,$t7,1
			j end_with_vowel
			not_vowel:
			addi $t3,$t3,1
			j checkifvowel
		end_no_vowel:
		addi $t0,$t0,1
		sb $t1,($t6)
		addi $t6,$t6,1
		j countvowels
		end_with_vowel:
		addi $t0,$t0,1
		j countvowels
	eos:
	lw $ra,($sp)
	move $v0,$t7
	jr $ra


