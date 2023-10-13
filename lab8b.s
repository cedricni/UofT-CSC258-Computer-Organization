.data 
# TODO: What are the following 5 lines doing?
promptA: .asciiz "Enter an int A: "
promptB: .asciiz "Enter an int B: "
resultA: .asciiz "A = "
resultB: .asciiz "B = "
newline: .asciiz "\n"

.globl main
.text

main: 
	li $v0, 4		      
	la $a0, promptA
	syscall    

	li $v0, 5
	syscall 
	move $t1, $v0

	li $v0, 4
	la $a0, promptB
	syscall

	li $v0, 5
	syscall 
	move $t2, $v0
	
	IF:
		slt $t3, $t1, $t2
		bne $t3, 0, ELSE
	THEN:
		addi $t1, $t1, 1
		j EXIT

	ELSE:
		subi $t2, $t2, 1
	EXIT:
	
	li $v0, 4
	la $a0, resultA
	syscall

	li $v0, 1
	move $a0, $t1	
	syscall 

	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
		la $a0, resultB
		syscall

		li $v0, 1
		move $a0, $t2	
		syscall 

		li $v0, 4
		la $a0, newline
		syscall
	
	li $v0, 10
	syscall
