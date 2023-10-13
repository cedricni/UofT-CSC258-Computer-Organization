.data 
array1: .word 5, 8, 3, 4, 7, 2
result: .asciiz "The product is: "
newline: .asciiz "\n"

.globl main
.text

main: 
	LOOPINIT:
		la $t0, array1
		li $t1, 1
		li $t3, 6
	WHILE:
		beq $t3, 0, DONE
		lw $t2, 0($t0)
		mult $t1, $t2
		mflo $t1
		addi $t0, $t0, 4
		subi $t3, $t3, 1
		j WHILE
	DONE:
		li $v0, 4
		la $a0, result
		syscall
		
		move $a0, $t1
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		li $v0, 10
		syscall
