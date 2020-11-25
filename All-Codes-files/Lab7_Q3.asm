.text
main:
   teqi $t0,0     # immediately trap because $t0 contains 0
   sw $3, 1($t0)  
   li   $v0, 10   # After return from exception handler, specify exit service
   syscall        # terminate normally
 
.ktext 0x80000180
move $k1,$t5   
sw $a0,save0  
sw $a1,save1 
 
mfc0 $k0, $13 
srl $a0, $k0, 2 
 
andi $a0, $a0, 0xf
bgtz $a0, done 
move $a0, $k0 
mfc0 $a1, $14 
jal print_excp 
 
done: mfc0 $k0, $14 
addiu $k0, $k0, 4 
mtc0 $k0, $14 
mtc0 $0, $13 
mfc0 $k0, $12 
andi $k0, 0xfffd 
ori $k0, 0x1 
mtc0 $k0, $12
lw $a0,save0
lw $a1,save1
move $t5,$k1
 
print_excp: 
   la   $a0,msg  # address of string to print
   li   $v0,4    # Print String service
   syscall
 
eret
.kdata
save0: .word 0
save1: .word 0
msg:   
   .asciiz "Trap generated:Excersie 3"