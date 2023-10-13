.data 
prompt: .asciiz "Enter an int: "
resultA: .asciiz "THIS IS ODD"
resultB: .asciiz "THIS IS EVEN"
newline: .asciiz "\n"

.globl main
.text

main: 
	li $v0, 4		      
	la $a0, prompt
	syscall    

	li $v0, 5
	syscall 
	move $t0, $v0

	IF:
		andi $t1, $t0, 0x1
		blez $t1 ELSE
	THEN:
		li $v0, 4
		la $a0, resultA
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		j DONE
	ELSE:
		li $v0, 4
		la $a0, resultB
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall 	
	DONE:
		li $v0, 10
		syscall