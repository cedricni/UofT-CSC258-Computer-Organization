.data 
promptA: .asciiz "Enter N: "
promptB: .asciiz "Enter an int: "
result: .asciiz "The product is: "
newline: .asciiz "\n"

.globl main
.text

main: 
	LOOPINIT:
		li $v0, 4		      
		la $a0, promptA
		syscall    

		li $v0, 5
		syscall 
		move $t0, $v0
		
		li $t1, 0
		li $t2, 1
	WHILE:
		beq $t1 $t0 DONE
		
		li $v0, 4		      
		la $a0, promptB
		syscall    

		li $v0, 5
		syscall 
		move $t3, $v0
		
		addi $t1, $t1, 1
		
		mult $t2, $t3
		mflo $t2
		
		j WHILE
	DONE:
		li $v0, 4
		la $a0, result
		syscall
		
		move $a0, $t2
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		li $v0, 10
		syscall
