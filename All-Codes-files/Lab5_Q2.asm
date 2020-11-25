.data

char: .byte 'u'
vowels: .asciiz "aeiou"
fstring: .asciiz "found"
nfstring: .asciiz "nfound"

.text

main:
lb $t0, char # load search char
li $t1, 0 # init not found
la $s0, vowels # pointer to vowels[0]
lb $s1, ($s0) # get vowels[0]

search:
beq $s1, $zero, not_found # '\0'
beq $s1, $t0, found # set t1 if found
addi $s0, $s0, 1 # no, step to next vowel
lb $s1, ($s0) # load next vowel
j search

not_found:
la $a0,nfstring
li $v0,4
syscall
j exit

found: 
la $a0,fstring
li $v0,4
syscall

exit:
li $v0, 10 
syscall