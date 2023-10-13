#####################################################################
#
# CSC258H5S Winter 2021 Assembly Programming Project
# University of Toronto Mississauga
#
# Group members:
# - Student 1: Tianshu Ni, 1005682673
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8					     
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4/5
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. Display the score on screen. The score should be constantly updated as the game progresses. 
# The final score is displayed on the game-over screen.
# 2. Dynamic on-screen notification messages during the game such as "COOL!", "GOOD!". 
# The notification should change over time.
# 3. Changing difficulty as game progresses: gradually increase the difficulty of the game as 
# the game progresses (i.e. faster doodle).
#
# Any additional information that the TA needs to know:
# - Basic buttons: j - left
#		   k - right
#		   s - restart the game
# HINT: press the button too fast will lead to the collapse of the program.
# - When scoring the mulptiple of 3, the scree will print a message, switcing
# between "COOL!" and "GOOD!".
# - When failing to jump onto the platform and dropping to the bottom, the game is
# over with "OPPS!" on the top of the game-over display. To restart the game press 's'.
# - Game difficulty: to demostrate, the difficulty variation is set to be quick and enhanced
# (i.e. when scoring 6 the doodle will move faster, and when scoring 12 the doodle will move
# much faster).
# The player need better judgement since the doodle will move quicker as the game processes.
# - Socre will be displayed in yellow on the game-over display, below the "OPPS!". For 
# programming convinience the maximum of the score is set as 99.
#
#####################################################################
.data
	displayAddress:	.word	0x10008000
.text
Init:
	li $s7, 0
	lw $t0, displayAddress	# $t0 stores the base address for display
	li $t1, 0xffffff	# $t1 stores the white colour code
	li $t2, 0xd4ff00	# $t2 stores the yellow colour code
	li $t3, 0xfc0320	# red
	li $t4, 0x22a4f0	# blue
	
	sw $t1, 3984($t0)
	sw $t1, 3988($t0)	# platform 1
	sw $t1, 3992($t0)	
	sw $t1, 3996($t0) 
	sw $t1, 4000($t0)
	sw $t1, 4004($t0)
	sw $t1, 4008($t0)
		
	sw $t1, 2612($t0) 	# platform 2
	sw $t1, 2616($t0)
	sw $t1, 2620($t0)
	sw $t1, 2624($t0)
	sw $t1, 2628($t0)
	sw $t1, 2632($t0)
	sw $t1, 2636($t0)
		 	 
	sw $t1, 1368($t0)	# platform 3
	sw $t1, 1372($t0)
	sw $t1, 1376($t0)
	sw $t1, 1380($t0)
	sw $t1, 1384($t0)
	sw $t1, 1388($t0)
	sw $t1, 1392($t0)
	
	sw $t2, 3868($t0)	# doodle
	sw $t2, 3740($t0)
	sw $t2, 3744($t0)
	sw $t2, 3616($t0)
	sw $t2, 3748($t0)
	sw $t2, 3876($t0)

	addi $s0, $s0, 3868 # store indices of doodle
	addi $s1, $s1, 3740
	addi $s2, $s2, 3744
	addi $s3, $s3, 3616
	addi $s4, $s4, 3748
	addi $s5, $s5, 3876
	j Up
Up:
	lw $t0, displayAddress
	beq $t6, 16, Down
	sgt $s6, $s7, 5
	beq $s6, 1, FasterU
	sgt $s6, $s7, 2
	beq $s6, 1, FastU
	li $v0, 32
	li $a0, 110
	syscall
	j UpThen
FastU:
	li $v0, 32
	li $a0, 80
	syscall
	j UpThen
FasterU:
	li $v0, 32
	li $a0, 60
	syscall
	j UpThen
UpThen:
	li $s6, 0
	lw $t8, 0xffff0000
	bnez $t8, KeyboardU
	add $t0, $t0, $s0 # checks the doodle
	lw $t5, -128($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	lw $t5, -128($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	lw $t5, -128($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	lw $t5, -128($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	lw $t5, -128($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	lw $t5, -128($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s5
	add $t0, $t0, $s0 #make doodle disappeared
	sw $zero, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $zero, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $zero, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $zero, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $zero, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $zero, 0($t0)
	sub $t0, $t0, $s5
	addi $s0, $s0, -128 #goes up 1 line
	addi $s1, $s1, -128
	addi $s2, $s2, -128
	addi $s3, $s3, -128
	addi $s4, $s4, -128
	addi $s5, $s5, -128
	add $t0, $t0, $s0 #repaints the doodle
	sw $t2, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $t2, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $t2, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $t2, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $t2, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $t2, 0($t0)
	sub $t0, $t0, $s5
	addi $t6, $t6, 1
	j Up
Down:
	li $t7, 0
	lw $t0, displayAddress
	li $t6, 0
	sgt $s6, $s7, 5
	beq $s6, 1, FasterD
	sgt $s6, $s7, 2
	beq $s6, 1, FastD
	li $v0, 32
	li $a0, 110
	syscall
	j DownThen
FasterD:
	li $v0, 32
	li $a0, 60
	syscall
	j DownThen
FastD:
	li $v0, 32
	li $a0, 80
	syscall
	j DownThen
DownThen:
	li $s6, 0
	lw $t8, 0xffff0000
	bnez $t8, KeyboardD

	add $t0, $t0, $s0 #checks the doodle
	lw $t5, 128($t0)
	beq $t5, $t1, PlatformChange
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	lw $t5, 128($t0)
	beq $t5, $t1, PlatformChange
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	lw $t5, 128($t0)
	beq $t5, $t1, PlatformChange
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	lw $t5, 128($t0)
	beq $t5, $t1, PlatformChange
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	lw $t5, 128($t0)
	beq $t5, $t1, PlatformChange
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	lw $t5, 128($t0)
	beq $t5, $t1, PlatformChange
	sub $t0, $t0, $s5
	
	add $t0, $t0, $s0 #make doodle disappeared
	sw $zero, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $zero, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $zero, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $zero, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $zero, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $zero, 0($t0)
	sub $t0, $t0, $s5
	addi $s0, $s0, 128 #goes down 1 line
	addi $s1, $s1, 128
	addi $s2, $s2, 128
	addi $s3, $s3, 128
	addi $s4, $s4, 128
	addi $s5, $s5, 128
	add $t0, $t0, $s0 #repaints the doodle
	sw $t2, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $t2, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $t2, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $t2, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $t2, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $t2, 0($t0)
	sub $t0, $t0, $s5
	sgt $t7, $s0, 3967
	beq $t7, 1, Opps
	sgt $t7, $s1, 3967
	beq $t7, 1, Opps
	sgt $t7, $s2, 3967
	beq $t7, 1, Opps
	sgt $t7, $s3, 3967
	beq $t7, 1, Opps
	sgt $t7, $s4, 3967
	beq $t7, 1, Opps
	sgt $t7, $s5, 3967
	beq $t7, 1, Opps
	j Down
UpR:
	lw $t0, displayAddress
	add $t0, $t0, $s0 #checks the doodle
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s5
	add $t0, $t0, $s0 #make doodle disappeared
	sw $zero, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $zero, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $zero, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $zero, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $zero, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $zero, 0($t0)
	sub $t0, $t0, $s5
	addi $s0, $s0, 4 #goes right 1 unit
	addi $s1, $s1, 4
	addi $s2, $s2, 4
	addi $s3, $s3, 4
	addi $s4, $s4, 4
	addi $s5, $s5, 4
	add $t0, $t0, $s0 #repaints the doodle
	sw $t2, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $t2, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $t2, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $t2, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $t2, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $t2, 0($t0)
	sub $t0, $t0, $s5
	j Up
DownR:
	lw $t0, displayAddress
	add $t0, $t0, $s0 #checks the doodle
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	lw $t5, 4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s5
	add $t0, $t0, $s0 #make doodle disappeared
	sw $zero, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $zero, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $zero, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $zero, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $zero, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $zero, 0($t0)
	sub $t0, $t0, $s5
	addi $s0, $s0, 4 #goes right 1 unit
	addi $s1, $s1, 4
	addi $s2, $s2, 4
	addi $s3, $s3, 4
	addi $s4, $s4, 4
	addi $s5, $s5, 4
	add $t0, $t0, $s0 #repaints the doodle
	sw $t2, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $t2, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $t2, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $t2, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $t2, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $t2, 0($t0)
	sub $t0, $t0, $s5
	j Down
UpL:
	lw $t0, displayAddress
	add $t0, $t0, $s0 #checks the doodle
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s5
	add $t0, $t0, $s0 #make doodle disappeared
	sw $zero, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $zero, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $zero, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $zero, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $zero, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $zero, 0($t0)
	sub $t0, $t0, $s5
	addi $s0, $s0, -4 #goes left 1 unit
	addi $s1, $s1, -4
	addi $s2, $s2, -4
	addi $s3, $s3, -4
	addi $s4, $s4, -4
	addi $s5, $s5, -4
	add $t0, $t0, $s0 #repaints the doodle
	sw $t2, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $t2, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $t2, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $t2, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $t2, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $t2, 0($t0)
	sub $t0, $t0, $s5
	j Up
DownL:
	lw $t0, displayAddress
	add $t0, $t0, $s0 #checks the doodle
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	lw $t5, -4($t0)
	beq $t5, $t1, Down
	sub $t0, $t0, $s5
	add $t0, $t0, $s0 #make doodle disappeared
	sw $zero, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $zero, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $zero, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $zero, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $zero, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $zero, 0($t0)
	sub $t0, $t0, $s5
	addi $s0, $s0, -4 #goes left 1 unit
	addi $s1, $s1, -4
	addi $s2, $s2, -4
	addi $s3, $s3, -4
	addi $s4, $s4, -4
	addi $s5, $s5, -4
	add $t0, $t0, $s0 #repaints the doodle
	sw $t2, 0($t0)
	sub $t0, $t0, $s0
	add $t0, $t0, $s1
	sw $t2, 0($t0)
	sub $t0, $t0, $s1
	add $t0, $t0, $s2
	sw $t2, 0($t0)
	sub $t0, $t0, $s2
	add $t0, $t0, $s3
	sw $t2, 0($t0)
	sub $t0, $t0, $s3
	add $t0, $t0, $s4
	sw $t2, 0($t0)
	sub $t0, $t0, $s4
	add $t0, $t0, $s5
	sw $t2, 0($t0)
	sub $t0, $t0, $s5
	j Down
KeyboardU:
	lw $t8, 0xffff0004
	beq $t8, 107, UpR
	beq $t8, 106, UpL
	beq $t8, 115, Reset
KeyboardD:
	lw $t8, 0xffff0004
	beq $t8, 107, DownR
	beq $t8, 106, DownL
	beq $t8, 115, Reset
Opps:
	li $t7, 0
	andi $t7, $s7, 1
	beq $t7, 0, GoodC
	j CoolC
GoodC:
	sw $zero, 156($t0) #GOOD
	sw $zero, 160($t0)
	sw $zero, 164($t0)
	sw $zero, 284($t0)
	sw $zero, 416($t0)
	sw $zero, 412($t0)
	sw $zero, 420($t0)
	sw $zero  540($t0)
	sw $zero, 548($t0)
	sw $zero, 668($t0)
	sw $zero, 676($t0)
	sw $zero, 672($t0)

	sw $zero, 172($t0)
	sw $zero, 176($t0)
	sw $zero, 180($t0)
	sw $zero, 300($t0)
	sw $zero, 308($t0)
	sw $zero, 428($t0)
	sw $zero, 436($t0)
	sw $zero  556($t0)
	sw $zero, 564($t0)
	sw $zero, 684($t0)
	sw $zero, 688($t0)
	sw $zero, 692($t0)

	sw $zero, 188($t0)
	sw $zero, 192($t0)
	sw $zero, 196($t0)
	sw $zero, 316($t0)
	sw $zero, 324($t0)
	sw $zero, 444($t0)
	sw $zero, 452($t0)
	sw $zero  572($t0)
	sw $zero, 580($t0)
	sw $zero, 700($t0)
	sw $zero, 704($t0)
	sw $zero, 708($t0)
	
	sw $zero, 204($t0)
	sw $zero, 208($t0)
	sw $zero, 332($t0)
	sw $zero, 340($t0)
	sw $zero, 460($t0)
	sw $zero, 468($t0)
	sw $zero  588($t0)
	sw $zero, 596($t0)
	sw $zero, 716($t0)
	sw $zero, 720($t0)
	
	sw $zero, 220($t0)
	sw $zero, 348($t0)
	sw $zero, 204($t0)
	sw $zero, 732($t0)
	sw $zero, 476($t0)
	
	j OppsThen
CoolC:
	sw $zero, 156($t0) #Cool
	sw $zero, 160($t0)
	sw $zero, 164($t0)
	sw $zero, 284($t0)
	sw $zero, 412($t0)
	sw $zero  540($t0)
	sw $zero, 668($t0)
	sw $zero, 676($t0)
	sw $zero, 672($t0)

	sw $zero, 172($t0)
	sw $zero, 176($t0)
	sw $zero, 180($t0)
	sw $zero, 300($t0)
	sw $zero, 308($t0)
	sw $zero, 428($t0)
	sw $zero, 436($t0)
	sw $zero  556($t0)
	sw $zero, 564($t0)
	sw $zero, 684($t0)
	sw $zero, 688($t0)
	sw $zero, 692($t0)

	sw $zero, 188($t0)
	sw $zero, 192($t0)
	sw $zero, 196($t0)
	sw $zero, 316($t0)
	sw $zero, 324($t0)
	sw $zero, 444($t0)
	sw $zero, 452($t0)
	sw $zero  572($t0)
	sw $zero, 580($t0)
	sw $zero, 700($t0)
	sw $zero, 704($t0)
	sw $zero, 708($t0)
	
	sw $zero, 204($t0)
	sw $zero, 332($t0)
	sw $zero, 460($t0)
	sw $zero  588($t0)
	sw $zero, 716($t0)
	sw $zero, 720($t0)
	sw $zero, 724($t0)
	
	sw $zero, 220($t0)
	sw $zero, 348($t0)
	sw $zero, 204($t0)
	sw $zero, 732($t0)
	sw $zero, 476($t0)
	
	j OppsThen
	
OppsThen:
	li $t7, 0
	sw $t3, 156($t0)
	sw $t3, 160($t0)
	sw $t3, 164($t0)
	sw $t3, 284($t0)
	sw $t3, 292($t0)
	sw $t3, 412($t0)
	sw $t3, 420($t0)
	sw $t3  540($t0)
	sw $t3, 548($t0)
	sw $t3, 668($t0)
	sw $t3, 676($t0)
	sw $t3, 672($t0)

	sw $t3, 172($t0)
	sw $t3, 176($t0)
	sw $t3, 180($t0)
	sw $t3, 300($t0)
	sw $t3, 308($t0)
	sw $t3, 428($t0)
	sw $t3, 432($t0)
	sw $t3, 436($t0)
	sw $t3, 556($t0)
	sw $t3, 684($t0)
	
	sw $t3, 204($t0)
	sw $t3, 208($t0)
	sw $t3, 212($t0)
	sw $t3, 332($t0)
	sw $t3, 460($t0)
	sw $t3, 464($t0)
	sw $t3, 468($t0)
	sw $t3, 596($t0)
	sw $t3, 716($t0)
	sw $t3, 720($t0)
	sw $t3, 724($t0)
	
	sw $t3, 188($t0)
	sw $t3, 192($t0)
	sw $t3, 196($t0)
	sw $t3, 316($t0)
	sw $t3, 324($t0)
	sw $t3, 444($t0)
	sw $t3, 448($t0)
	sw $t3, 452($t0)
	sw $t3, 572($t0)
	sw $t3, 700($t0)
	
	sw $t3, 220($t0)
	sw $t3, 348($t0)
	sw $t3, 204($t0)
	sw $t3, 732($t0)
	sw $t3, 476($t0)
	
	slti $t7, $s7, 10
	beq $t7, 1, One
	j TwoS
TwoS:
	li $t8, 10
	div $s7, $t8
	mflo $t7
	mult $t7, $t8
	mflo $t7
	sub $t7, $s7, $t7
	
	beq $t7, 0, SZero
	beq $t7, 2, STwo
	beq $t7, 3, SThree
	beq $t7, 4, SFour
	beq $t7, 5, SFive
	beq $t7, 6, SSix
	beq $t7, 7, SSeven
	beq $t7, 8, SEight
	beq $t7, 9, SNine
	beq $t7, 1, SOne
TwoF:
	sub $t7, $s7, $t7
	div $t7, $t8
	mflo $t7
	
	beq $t7, 2, FTwo
	beq $t7, 3, FThree
	beq $t7, 4, FFour
	beq $t7, 5, FFive
	beq $t7, 6, FSix
	beq $t7, 7, FSeven
	beq $t7, 8, FEight
	beq $t7, 9, FNine
	beq $t7, 1, FOne
FOne:
	sw $t2, 948($t0)
	sw $t2, 1076($t0)
	sw $t2, 1204($t0)
	sw $t2, 1332($t0)
	sw $t2, 1460($t0)
	j OppsLast
FTwo:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1076($t0)
	sw $t2, 1204($t0)
	sw $t2, 1200($t0)
	sw $t2, 1196($t0)
	sw $t2, 1324($t0)
	sw $t2, 1460($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	j OppsLast
FThree:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1076($t0)
	sw $t2, 1204($t0)
	sw $t2, 1200($t0)
	sw $t2, 1196($t0)
	sw $t2, 1332($t0)
	sw $t2, 1460($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	j OppsLast
FFour:
	sw $t2, 940($t0)
	sw $t2, 1068($t0)
	sw $t2, 1196($t0)
	sw $t2, 1200($t0)
	sw $t2, 948($t0)
	sw $t2, 1076($t0)
	sw $t2, 1204($t0)
	sw $t2, 1332($t0)
	sw $t2, 1460($t0)
	j OppsLast
FFive:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1200($t0)
	sw $t2, 1332($t0)
	sw $t2, 1460($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	j OppsLast
FSix:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1200($t0)
	sw $t2, 1332($t0)
	sw $t2, 1460($t0)
	sw $t2, 1324($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	j OppsLast
FSeven:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1076($t0)
	sw $t2, 1204($t0)
	sw $t2, 1332($t0)
	sw $t2, 1460($t0)
	j OppsLast
FEight:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1200($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1460($t0)
	sw $t2, 1456($t0)
	sw $t2, 1452($t0)
	j OppsLast
FNine:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1200($t0)
	sw $t2, 1204($t0)
	sw $t2, 1332($t0)
	sw $t2, 1460($t0)
	sw $t2, 1456($t0)
	sw $t2, 1452($t0)
	j OppsLast
SZero:
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1084($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1220($t0)
	sw $t2, 1340($t0)
	sw $t2, 1348($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	sw $t2, 1476($t0)
	j TwoF
SOne:
	sw $t2, 964($t0)
	sw $t2, 1092($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	j TwoF
STwo:
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1216($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1220($t0)
	sw $t2, 1340($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	sw $t2, 1476($t0)
	j TwoF
SThree:
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	sw $t2, 1476($t0)
	j TwoF
SFour:
	sw $t2, 956($t0)
	sw $t2, 1084($t0)
	sw $t2, 964($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	j TwoF
SFive:
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 1084($t0)
	sw $t2, 964($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	sw $t2, 1472($t0)
	sw $t2, 1468($t0)
	j TwoF
SSix:
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 1084($t0)
	sw $t2, 964($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	sw $t2, 1340($t0)
	sw $t2, 1472($t0)
	sw $t2, 1468($t0)
	j TwoF
SSeven:
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1092($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	j TwoF
SEight:
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1084($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1340($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	j TwoF
SNine:
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1084($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	j TwoF
One:
	beq $s7, 0, OneZero
	beq $s7, 2, OneTwo
	beq $s7, 3, OneThree
	beq $s7, 4, OneFour
	beq $s7, 5, OneFive
	beq $s7, 6, OneSix
	beq $s7, 7, OneSeven
	beq $s7, 8, OneEight
	beq $s7, 9, OneNine
	beq $s7, 1, OneOne
	
OneZero:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1084($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1220($t0)
	sw $t2, 1340($t0)
	sw $t2, 1348($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	sw $t2, 1476($t0)
	j OppsLast
OneOne:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 964($t0)
	sw $t2, 1092($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	j OppsLast
OneTwo:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1216($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1220($t0)
	sw $t2, 1340($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	sw $t2, 1476($t0)
	j OppsLast
OneThree:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	sw $t2, 1476($t0)
	j OppsLast
OneFour:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 956($t0)
	sw $t2, 1084($t0)
	sw $t2, 964($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	j OppsLast
OneFive:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 1084($t0)
	sw $t2, 964($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	sw $t2, 1472($t0)
	sw $t2, 1468($t0)
	j OppsLast
OneSix:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 1084($t0)
	sw $t2, 964($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	sw $t2, 1340($t0)
	sw $t2, 1472($t0)
	sw $t2, 1468($t0)
	j OppsLast
OneSeven:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1092($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	j OppsLast
OneEight:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1084($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1340($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	j OppsLast
OneNine:
	sw $t2, 940($t0)
	sw $t2, 944($t0)
	sw $t2, 948($t0)
	sw $t2, 1068($t0)
	sw $t2, 1076($t0)
	sw $t2, 1196($t0)
	sw $t2, 1204($t0)
	sw $t2, 1324($t0)
	sw $t2, 1332($t0)
	sw $t2, 1452($t0)
	sw $t2, 1456($t0)
	sw $t2, 1460($t0)
	
	sw $t2, 956($t0)
	sw $t2, 960($t0)
	sw $t2, 964($t0)
	sw $t2, 1084($t0)
	sw $t2, 1092($t0)
	sw $t2, 1212($t0)
	sw $t2, 1216($t0)
	sw $t2, 1220($t0)
	sw $t2, 1348($t0)
	sw $t2, 1476($t0)
	sw $t2, 1468($t0)
	sw $t2, 1472($t0)
	j OppsLast
OppsLast:
	li $t7, 0
	lw $t8, 0xffff0004
	beq $t8, 115, Reset
	j OppsThen
Reset:
	sw $zero, 0($t0)
	addi $t7, $t7, 4
	lw $t0, displayAddress
	add $t0, $t0, $t7
	beq $t7, 4096, Restart
	j Reset
Restart:
	li $t7, 0
	lw $t0, displayAddress
	
	sw $t1, 3984($t0)
	sw $t1, 3988($t0)	# platform 1
	sw $t1, 3992($t0)	
	sw $t1, 3996($t0) 
	sw $t1, 4000($t0)
	sw $t1, 4004($t0)
	sw $t1, 4008($t0)
		
	sw $t1, 2612($t0) 	# platform 2
	sw $t1, 2616($t0)
	sw $t1, 2620($t0)
	sw $t1, 2624($t0)
	sw $t1, 2628($t0)
	sw $t1, 2632($t0)
	sw $t1, 2636($t0)
		 	 
	sw $t1, 1368($t0)	# platform 3
	sw $t1, 1372($t0)
	sw $t1, 1376($t0)
	sw $t1, 1380($t0)
	sw $t1, 1384($t0)
	sw $t1, 1388($t0)
	sw $t1, 1392($t0)
	
	sw $t2, 3868($t0)
	sw $t2, 3740($t0)
	sw $t2, 3744($t0)
	sw $t2, 3616($t0)
	sw $t2, 3748($t0)
	sw $t2, 3876($t0)
	
	li $s0, 3868 #store indices of doodle
	li $s1, 3740
	li $s2, 3744
	li $s3, 3616
	li $s4, 3748
	li $s5, 3876
	
	li $s7, 0
	j Up
PlatformChange:
	sge $t7, $s0, 3839
	beq $t7, 1, Up
			
	sge $t7, $s5, 2519
	beq $t7, 1, Change2
	
	sge $t7, $s5, 2483
	beq $t7, 1, Change1
	
	
	
	j Change3
Change1:
	lw $t0, displayAddress
	addi $s7, $s7, 1
	subi $t7, $s7, 1
	andi $t7, $t7, 1
	beq $t7, 0, GoodClean
	j CoolClean
	
GoodClean:
	sw $zero, 156($t0) #GOOD
	sw $zero, 160($t0)
	sw $zero, 164($t0)
	sw $zero, 284($t0)
	sw $zero, 416($t0)
	sw $zero, 412($t0)
	sw $zero, 420($t0)
	sw $zero  540($t0)
	sw $zero, 548($t0)
	sw $zero, 668($t0)
	sw $zero, 676($t0)
	sw $zero, 672($t0)

	sw $zero, 172($t0)
	sw $zero, 176($t0)
	sw $zero, 180($t0)
	sw $zero, 300($t0)
	sw $zero, 308($t0)
	sw $zero, 428($t0)
	sw $zero, 436($t0)
	sw $zero  556($t0)
	sw $zero, 564($t0)
	sw $zero, 684($t0)
	sw $zero, 688($t0)
	sw $zero, 692($t0)

	sw $zero, 188($t0)
	sw $zero, 192($t0)
	sw $zero, 196($t0)
	sw $zero, 316($t0)
	sw $zero, 324($t0)
	sw $zero, 444($t0)
	sw $zero, 452($t0)
	sw $zero  572($t0)
	sw $zero, 580($t0)
	sw $zero, 700($t0)
	sw $zero, 704($t0)
	sw $zero, 708($t0)
	
	sw $zero, 204($t0)
	sw $zero, 208($t0)
	sw $zero, 332($t0)
	sw $zero, 340($t0)
	sw $zero, 460($t0)
	sw $zero, 468($t0)
	sw $zero  588($t0)
	sw $zero, 596($t0)
	sw $zero, 716($t0)
	sw $zero, 720($t0)
	
	sw $zero, 220($t0)
	sw $zero, 348($t0)
	sw $zero, 204($t0)
	sw $zero, 732($t0)
	sw $zero, 476($t0)
	
	j C1Init
CoolClean:
	sw $zero, 156($t0) #Cool
	sw $zero, 160($t0)
	sw $zero, 164($t0)
	sw $zero, 284($t0)
	sw $zero, 412($t0)
	sw $zero  540($t0)
	sw $zero, 668($t0)
	sw $zero, 676($t0)
	sw $zero, 672($t0)

	sw $zero, 172($t0)
	sw $zero, 176($t0)
	sw $zero, 180($t0)
	sw $zero, 300($t0)
	sw $zero, 308($t0)
	sw $zero, 428($t0)
	sw $zero, 436($t0)
	sw $zero  556($t0)
	sw $zero, 564($t0)
	sw $zero, 684($t0)
	sw $zero, 688($t0)
	sw $zero, 692($t0)

	sw $zero, 188($t0)
	sw $zero, 192($t0)
	sw $zero, 196($t0)
	sw $zero, 316($t0)
	sw $zero, 324($t0)
	sw $zero, 444($t0)
	sw $zero, 452($t0)
	sw $zero  572($t0)
	sw $zero, 580($t0)
	sw $zero, 700($t0)
	sw $zero, 704($t0)
	sw $zero, 708($t0)
	
	sw $zero, 204($t0)
	sw $zero, 332($t0)
	sw $zero, 460($t0)
	sw $zero  588($t0)
	sw $zero, 716($t0)
	sw $zero, 720($t0)
	sw $zero, 724($t0)
	
	sw $zero, 220($t0)
	sw $zero, 348($t0)
	sw $zero, 204($t0)
	sw $zero, 732($t0)
	sw $zero, 476($t0)
	
	j C1Init
C1Init:	
	sw $zero, 3984($t0)
	sw $zero, 3988($t0)	# platform 1
	sw $zero, 3992($t0)	
	sw $zero, 3996($t0) 
	sw $zero, 4000($t0)
	sw $zero, 4004($t0)
	sw $zero, 4008($t0)
	
	
	sw $zero, 2612($t0) # platform 2
	sw $zero, 2616($t0)
	sw $zero, 2620($t0)
	sw $zero, 2624($t0)
	sw $zero, 2628($t0)
	sw $zero, 2632($t0)
	sw $zero, 2636($t0)
 
	 
	sw $zero, 1368($t0) # platform 3
	sw $zero, 1372($t0)
	sw $zero, 1376($t0)
	sw $zero, 1380($t0)
	sw $zero, 1384($t0)
	sw $zero, 1388($t0)
	sw $zero, 1392($t0)
	
	sw $t1, 16($t0)
	sw $t1, 20($t0)	# platform 1
	sw $t1, 24($t0)	
	sw $t1, 28($t0) 
	sw $t1, 32($t0)
	sw $t1, 36($t0)
	sw $t1, 40($t0)
	
	sw $t1, 2740($t0) # platform 2
	sw $t1, 2744($t0)
	sw $t1, 2748($t0)
	sw $t1, 2752($t0)
	sw $t1, 2756($t0)
	sw $t1, 2760($t0)
	sw $t1, 2764($t0)
 
	 # platform 3
	sw $t1, 1496($t0)
	sw $t1, 1500($t0)
	sw $t1, 1504($t0)
	sw $t1, 1508($t0)
	sw $t1, 1512($t0)
	sw $t1, 1516($t0)
	sw $t1, 1520($t0)
	
	li $t5, 16
	li $t8, 2740
	li $t9, 1496
	li $t6, 9
	
	C1F:
		beq $t6, 0, C1Then
		li $v0, 32
		li $a0, 20
		syscall
		
		add $t0, $t0, $t5
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t5
		
		add $t0, $t0, $t8
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t8
		
		add $t0, $t0, $t9
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t9
		
		addi $t5, $t5, 128
		addi $t8, $t8, 128
		addi $t9, $t9, 128
		
		add $t0, $t0, $t5
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t5
		
		add $t0, $t0, $t8
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t8
		
		add $t0, $t0, $t9
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t9
		
		subi $t6, $t6, 1
		j C1F
	C1Then:
		li $v0, 32
		li $a0, 20
		syscall
		
		add $t0, $t0, $t5
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t5
		
		add $t0, $t0, $t8
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t8
		
		addi $t5, $t5, 128
		addi $t8, $t8, 128
		
		add $t0, $t0, $t5
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t5
		
		add $t0, $t0, $t8
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t8
	
		j Down
Change2:
	addi $s7, $s7, 1
	lw $t0, displayAddress
	sw $zero, 1296($t0)
	sw $zero, 1300($t0)	# platform 1
	sw $zero, 1304($t0)	
	sw $zero, 1308($t0) 
	sw $zero, 1312($t0)
	sw $zero, 1316($t0)
	sw $zero, 1320($t0)
	
	sw $zero, 4020($t0) # platform 2
	sw $zero, 4024($t0)
	sw $zero, 4028($t0)
	sw $zero, 4032($t0)
	sw $zero, 4036($t0)
	sw $zero, 4040($t0)
	sw $zero, 4044($t0)
 
	sw $zero, 2648($t0)# platform 3
	sw $zero, 2652($t0)
	sw $zero, 2656($t0)
	sw $zero, 2660($t0)
	sw $zero, 2664($t0)
	sw $zero, 2668($t0)
	sw $zero, 2672($t0)
	
	sw $t1, 1424($t0)
	sw $t1, 1428($t0)	# platform 1
	sw $t1, 1432($t0)	
	sw $t1, 1436($t0) 
	sw $t1, 1440($t0)
	sw $t1, 1444($t0)
	sw $t1, 1448($t0)
	
	sw $t1, 52($t0) # platform 2
	sw $t1, 56($t0)
	sw $t1, 60($t0)
	sw $t1, 64($t0)
	sw $t1, 68($t0)
	sw $t1, 72($t0)
	sw $t1, 76($t0)
  
	sw $t1, 2776($t0)# platform 3
	sw $t1, 2780($t0)
	sw $t1, 2784($t0)
	sw $t1, 2788($t0)
	sw $t1, 2792($t0)
	sw $t1, 2796($t0)
	sw $t1, 2800($t0)
	
	li $t5, 1424
	li $t8, 52
	li $t9, 2776
	li $t6, 9
	
	C2F:
		beq $t6, 0, C2Then
		li $v0, 32
		li $a0, 20
		syscall
		
		add $t0, $t0, $t5
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t5
		
		add $t0, $t0, $t8
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t8
		
		add $t0, $t0, $t9
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t9
		
		addi $t5, $t5, 128
		addi $t8, $t8, 128
		addi $t9, $t9, 128
		
		add $t0, $t0, $t5
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t5
		
		add $t0, $t0, $t8
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t8
		
		add $t0, $t0, $t9
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t9
		
		subi $t6, $t6, 1
		j C2F
		
	C2Then:
		li $v0, 32
		li $a0, 20
		syscall
		
		add $t0, $t0, $t9
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t9
		
		add $t0, $t0, $t8
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t8
		
		addi $t9, $t9, 128
		addi $t8, $t8, 128
		
		add $t0, $t0, $t9
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t9
		
		add $t0, $t0, $t8
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t8
		
		j Down
Change3:
	addi $s7, $s7, 1
	lw $t0, displayAddress
	sw $zero, 2576($t0)
	sw $zero, 2580($t0)	# platform 1
	sw $zero, 2584($t0)	
	sw $zero, 2588($t0) 
	sw $zero, 2592($t0)
	sw $zero, 2596($t0)
	sw $zero, 2600($t0)
	
	sw $zero, 1332($t0) # platform 2
	sw $zero, 1336($t0)
	sw $zero, 1340($t0)
	sw $zero, 1344($t0)
	sw $zero, 1348($t0)
	sw $zero, 1352($t0)
	sw $zero, 1356($t0)
 
	sw $zero, 4056($t0)# platform 3
	sw $zero, 4060($t0)
	sw $zero, 4064($t0)
	sw $zero, 4068($t0)
	sw $zero, 4072($t0)
	sw $zero, 4076($t0)
	sw $zero, 4080($t0)
	
	sw $t1, 2704($t0)
	sw $t1, 2708($t0)	# platform 1
	sw $t1, 2712($t0)	
	sw $t1, 2716($t0) 
	sw $t1, 2720($t0)
	sw $t1, 2724($t0)
	sw $t1, 2728($t0)
	
	sw $t1, 1460($t0) # platform 2
	sw $t1, 1464($t0)
	sw $t1, 1468($t0)
	sw $t1, 1472($t0)
	sw $t1, 1476($t0)
	sw $t1, 1480($t0)
	sw $t1, 1484($t0)
  
	sw $t1, 88($t0)# platform 3
	sw $t1, 92($t0)
	sw $t1, 96($t0)
	sw $t1, 100($t0)
	sw $t1, 104($t0)
	sw $t1, 108($t0)
	sw $t1, 112($t0)
	
	li $t5, 2704
	li $t8, 1460
	li $t9, 88
	li $t6, 9
	
	C3F:
		beq $t6, 0, C3Then
		li $v0, 32
		li $a0, 20
		syscall
		
		add $t0, $t0, $t5
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t5
		
		add $t0, $t0, $t8
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t8
		
		add $t0, $t0, $t9
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t9
		
		addi $t5, $t5, 128
		addi $t8, $t8, 128
		addi $t9, $t9, 128
		
		add $t0, $t0, $t5
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t5
		
		add $t0, $t0, $t8
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t8
		
		add $t0, $t0, $t9
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t9
		
		subi $t6, $t6, 1
		j C3F
		
	C3Then:
		li $v0, 32
		li $a0, 20
		syscall
		
		add $t0, $t0, $t9
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t9
		
		add $t0, $t0, $t5
		sw $zero, 0($t0)	# platform 1
		sw $zero, 4($t0)	
		sw $zero, 8($t0) 
		sw $zero, 12($t0)
		sw $zero, 16($t0)
		sw $zero, 20($t0)
		sw $zero, 24($t0)
		sub $t0, $t0, $t5
		
		addi $t9, $t9, 128
		addi $t5, $t5, 128
		
		add $t0, $t0, $t9
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t9
		
		add $t0, $t0, $t5
		sw $t1, 0($t0)	# platform 1
		sw $t1, 4($t0)	
		sw $t1, 8($t0) 
		sw $t1, 12($t0)
		sw $t1, 16($t0)
		sw $t1, 20($t0)
		sw $t1, 24($t0)
		sub $t0, $t0, $t5
	
		andi $t7, $s7, 1
		beq $t7, 0, Good
		j Cool
		
	Good:
		sw $t4, 156($t0) #GOOD
		sw $t4, 160($t0)
		sw $t4, 164($t0)
		sw $t4, 284($t0)
		sw $t4, 416($t0)
		sw $t4, 412($t0)
		sw $t4, 420($t0)
		sw $t4  540($t0)
		sw $t4, 548($t0)
		sw $t4, 668($t0)
		sw $t4, 676($t0)
		sw $t4, 672($t0)
	
		sw $t4, 172($t0)
		sw $t4, 176($t0)
		sw $t4, 180($t0)
		sw $t4, 300($t0)
		sw $t4, 308($t0)
		sw $t4, 428($t0)
		sw $t4, 436($t0)
		sw $t4  556($t0)
		sw $t4, 564($t0)
		sw $t4, 684($t0)
		sw $t4, 688($t0)
		sw $t4, 692($t0)
	
		sw $t4, 188($t0)
		sw $t4, 192($t0)
		sw $t4, 196($t0)
		sw $t4, 316($t0)
		sw $t4, 324($t0)
		sw $t4, 444($t0)
		sw $t4, 452($t0)
		sw $t4  572($t0)
		sw $t4, 580($t0)
		sw $t4, 700($t0)
		sw $t4, 704($t0)
		sw $t4, 708($t0)
	
		sw $t4, 204($t0)
		sw $t4, 208($t0)
		sw $t4, 332($t0)
		sw $t4, 340($t0)
		sw $t4, 460($t0)
		sw $t4, 468($t0)
		sw $t4  588($t0)
		sw $t4, 596($t0)
		sw $t4, 716($t0)
		sw $t4, 720($t0)
	
		sw $t4, 220($t0)
		sw $t4, 348($t0)
		sw $t4, 204($t0)
		sw $t4, 732($t0)
		sw $t4, 476($t0)
		j Down
	Cool:
		sw $t4, 156($t0) #Cool
		sw $t4, 160($t0)
		sw $t4, 164($t0)
		sw $t4, 284($t0)
		sw $t4, 412($t0)
		sw $t4  540($t0)
		sw $t4, 668($t0)
		sw $t4, 676($t0)
		sw $t4, 672($t0)
	
		sw $t4, 172($t0)
		sw $t4, 176($t0)
		sw $t4, 180($t0)
		sw $t4, 300($t0)
		sw $t4, 308($t0)
		sw $t4, 428($t0)
		sw $t4, 436($t0)
		sw $t4  556($t0)
		sw $t4, 564($t0)
		sw $t4, 684($t0)
		sw $t4, 688($t0)
		sw $t4, 692($t0)
	
		sw $t4, 188($t0)
		sw $t4, 192($t0)
		sw $t4, 196($t0)
		sw $t4, 316($t0)
		sw $t4, 324($t0)
		sw $t4, 444($t0)
		sw $t4, 452($t0)
		sw $t4  572($t0)
		sw $t4, 580($t0)
		sw $t4, 700($t0)
		sw $t4, 704($t0)
		sw $t4, 708($t0)
	
		sw $t4, 204($t0)
		sw $t4, 332($t0)
		sw $t4, 460($t0)
		sw $t4  588($t0)
		sw $t4, 716($t0)
		sw $t4, 720($t0)
		sw $t4, 724($t0)
		
		sw $t4, 220($t0)
		sw $t4, 348($t0)
		sw $t4, 204($t0)
		sw $t4, 732($t0)
		sw $t4, 476($t0)
		j Down
Exit:
	li $v0, 10 # terminate the program gracefully
	syscall
