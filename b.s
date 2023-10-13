.data
return: .asciiz "\n"
.text
li $t0, 0
li $t8, 3
For: 
     beq $t0, 10, Done
     div $t0, $t8
     mflo $t1
     mult $t1, $t8
     mflo $t1
     sub $t3, $t0, $t1
     move $t5, $t0
     addi $t5, $t5, 1
     beq $t3, 0, F
     move $t5, $t0
     addi $t5, $t5, 1
     beq $t3, 1, S
     move $t5, $t0
     addi $t5, $t5, 1
     beq $t3, 2, T
Print:
     PrintFor:
           beq $t5, 0, Then
           li $v0, 1
           move $a0, $t2
           syscall
           addi $t5, $t5, -1
           j PrintFor
Then:
     li $v0, 4
     la $a0, return
     syscall
 
     addi $t0, $t0, 1
     j For
F:
     add $t2, $zero 2
     j Print
S:
     add $t2, $zero, 5
     j Print
T:
     add $t2, $zero, 8
     j Print
Done: