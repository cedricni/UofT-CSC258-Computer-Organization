.data 
prompt: .asciiz "Enter an number: "
result: .asciiz "The result is: "
newline: .asciiz "\n"

.globl main
.text

main: 
	li $v0, 4		      
	la $a0, prompt
	syscall    

	li $v0, 5
	syscall 

	move $a0, $v0	
	jal mystery
	
	move $t0, $v0
	
	li $v0, 4		      
	la $a0, result
	syscall   
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
		
	li $v0, 10
	syscall
	
mystery:
	addi $sp, $sp, -8
    	sw $s0, 4($sp)
    	sw $ra, 0($sp)
    	bne $a0, 0, else
    	addi $v0, $zero, 0
    	j return
else:
	move $s0, $a0
    	addi $a0, $a0, -1
    	jal mystery

    	li $s1, 2
    	mult $s0, $s1
    	mflo $s2
    	subi $s2, $s2, 1
    	add $v0, $v0, $s2
return:
    	lw $s0, 4($sp)
    	lw $ra, 0($sp)
    	addi $sp, $sp, 8
    	jr $ra
		
		
