.text
main:
   teqi $t0,0     # immediately trap because $t0 contains 0
   li $v0, 10   # After return from exception handler, specify exit service
   syscall        # terminate normally
 

.ktext 0x80000180
mov $k1, $at # Save $at register. $k1,$k2 are exception handler register
sw $a0, save0 # Handler is not re-entrant(i.e interrupts are disabled) and can’t use
sw $a1, save1 # stack to save $a0, $a1
mfc0 $k0, $13 # Move Cause into $k0, $13 is CAUSE register
srl $a0, $k0, 2 # Extract ExcCode field(bits 2-6 in cause register)
andi $a0, $a0, 0xf
bgtz $a0, done # Branch if ExcCode is int (0)
mov $a0, $k0 # Move Cause into $a0
mfc0 $a1, $14 # Move EPC into $a1
jal print_excp # Print exception error message

done: 
mfc0 $k0, $14 # Bump EPC
addiu $k0, $k0, 4 # Do not re-execute faulting instruction
mtc0 $k0, $14 # EPC
mtc0 $0, $13 # Clear Cause register
mfc0 $k0, $12 # Fix Status register
andi $k0, 0xfffd
ori $k0, 0x1 # Enable interrupts
mtc0 $k0, $12
lw $a0, save0
lw $a1, save1
mov $at, $k1
eret

print_excp:
addi $sp,$sp,-8 
sw $a0,($sp) 
sw $ra,4($sp) #since we are having nested procedure, which will overwrite the current value of $ra
la $a0,msg
li $v0,5
syscall
lw $a0,($sp) #restore the value of $a0, main function should get old value of $a0
lw $ra,4($sp) #restore the value of $ra
addi $sp,$sp,8 
jr $ra

.kdata
save0: .word 0
save1: .word 0
msg: .asciiz "hello error\n"