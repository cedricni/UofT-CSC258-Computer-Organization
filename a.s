.data
    pitchC: .byte 60
    pitchD: .byte 62
    pitchE: .byte 64
    pitchF: .byte 65
    pitchG: .byte 67
    pitchA: .byte 69
    pitchB: .byte 71
    pitchCC: .byte 72
    instrument: .byte 7
    volume: .byte 127
    duration: .byte 80
.text
main:
    while:
    	li $v0, 32
	li $a0, 80
	syscall
	
        li $v0, 31
        lb $a0, pitchC
        lb $a1, duration
        lb $a2, instrument
        lb $a3, volume
        syscall
	
	li $v0, 32
	li $a0, 80
	syscall
	
	li $v0, 31
        lb $a0, pitchD
        lb $a1, duration
        lb $a2, instrument
        lb $a3, volume
        syscall
        
        li $v0, 32
	li $a0, 80
	syscall
	
        li $v0, 31
        lb $a0, pitchE
        lb $a1, duration
        lb $a2, instrument
        lb $a3, volume
        syscall
        
        li $v0, 32
	li $a0, 80
	syscall
	
        li $v0, 31
        lb $a0, pitchF
        lb $a1, duration
        lb $a2, instrument
        lb $a3, volume
        syscall
        
        li $v0, 32
	li $a0, 80
	syscall
	
        li $v0, 31
        lb $a0, pitchG
        lb $a1, duration
        lb $a2, instrument
        lb $a3, volume
        syscall
        
        li $v0, 32
	li $a0, 80
	syscall
	
        li $v0, 31
        lb $a0, pitchA
        lb $a1, duration
        lb $a2, instrument
        lb $a3, volume
        syscall
        
        li $v0, 32
	li $a0, 80
	syscall
	
        li $v0, 31
        lb $a0, pitchB
        lb $a1, duration
        lb $a2, instrument
        lb $a3, volume
        syscall

        j while 

