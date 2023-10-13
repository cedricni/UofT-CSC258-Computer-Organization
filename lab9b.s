.data 
prompt: .asciiz "Enter an int: "
result: .asciiz "TOO MANY TIMES"
newline: .asciiz "\n"
N: .word 5

.globl main
.text

main: 
	LOOPINIT:
		lw $t0, N
		li $t1, 0
	WHILE:
		li $v0, 4		      
		la $a0, prompt
		syscall    

		li $v0, 5
		syscall 
		move $t2, $v0
		
		andi $t3, $t2, 0x1
		blez $t3 DONE
		
		addi $t1, $t1, 1
		beq $t0, $t1, DONE2
		
		j WHILE
	DONE:
		li $v0, 10
		syscall
	DONE2:
		li $v0, 4
		la $a0, result
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		li $v0, 10
		syscall