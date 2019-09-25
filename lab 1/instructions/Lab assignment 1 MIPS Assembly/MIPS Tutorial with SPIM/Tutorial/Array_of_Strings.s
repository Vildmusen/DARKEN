	.data
	
STR_1:  .asciiz "The sum of "
STR_2:  .asciiz " and "
STR_3:  .asciiz " is "
	
ARRAY_OF_STRINGS:
	# Each element is an address to a string.
	.word STR_1, STR_2, STR_3  
	
	.text
        .globl main
main:		
	# Just for fun,  get  the address of 
        # label "ARRAY_OF_STRINGS":

	la	$t0, ARRAY_OF_STRINGS
	
	addi	$a1, $zero, 3		# a
	addi	$a2, $zero, 11		# b

	# Must copy $a0 since the 
       	# syscalls used later uses $a0

	add	$t0, $a0, $zero 	
	
	# Print "The sum of "
	li      	$v0, 4
        lw	$a0, ARRAY_OF_STRINGS	
        syscall

	# Print the value of a
	li	$v0, 1
	add	$a0, $zero, $a1
	syscall
	
	# Print  " and "
	li      $v0, 4
	lw	$a0, ARRAY_OF_STRINGS + 4
        syscall

	# Print the value of b
	li	$v0, 1
	add	$a0, $zero, $a2
	syscall

	# Print " is "
	li      $v0, 4
        lw	$a0, ARRAY_OF_STRINGS + 8
       	 syscall         

	# Print the sum a + b
	li	$v0, 1
	add	$a0, $a1, $a2
	syscall

	jr	$ra		
	