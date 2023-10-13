.data
newline: .asciiz "\n"
.globl main
.text

main: 
	addi $t1, $t1, -22
	addi $t2, $t2, -2
	xor $t3, $t1, $t2
	xor $t1, $t1, $t2
	xor $t2, $t1, $t2
	xor $t1, $t2, $t1
	
	move $a0, $t1
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	move $a0, $t2
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	
	li $v0, 10
	syscall
 

    