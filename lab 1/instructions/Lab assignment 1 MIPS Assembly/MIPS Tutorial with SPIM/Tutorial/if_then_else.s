	.data
STR_THEN:    .asciiz "equal"
STR_ELSE:    .asciiz "not equal" 	
	.text
        .globl main

main:   li	$t0, 15			# a
	addi	$t1, $zero, 15		# b

if:	bne $t0, $t1, else		# if (a==b) 
	
then:	# system call for print_str	# print equal 

	li     	$v0, 4                  
	la	$a0, STR_THEN
	syscall
	j end_if
else:
	# system call for print_str  	# print not equal 	
	li      $v0, 4                  
	la	$a0, STR_ELSE
	syscall

end_if:	jr 	$ra
