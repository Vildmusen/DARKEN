	.text
        .globl main
	
main:   add	$t0, $zero, $zero  	# loop counter i
        addi	$s0 ,$zero, 5		# loop limit N
	
loop:   beq $t0, $s0, done		# for i = 0...(N-1)

	add	$a0, $zero, $t0		# print i
	# system call code for print_int  
       	li	$v0, 1			
	syscall
	
       	addi $t0, $t0, 1		# i ++ 
	
       	j loop				#  loop again
	
done:	jr	$ra			#  return to caller

