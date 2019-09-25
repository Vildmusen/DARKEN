	.data
STR:    .asciiz "Hello world, your lucky number is: "  
	.text
        	.globl main
main:	
	# system call code for print_str
	li      $v0, 4
	# address of string to print
       	la      $a0, STR	
       	syscall         

	# system call code for print_int
	li	$v0, 1
	# integer to print
	addi	$a0, $zero, 44	
	syscall
	
	jr	$ra
