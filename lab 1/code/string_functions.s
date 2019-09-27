	.data
	
ARRAY_SIZE:
	.word	0	# Change here to try other values (less than 10)
FIBONACCI_ARRAY:
	.word	1, 1, 2, 3, 5, 8, 13, 21, 34, 55
STR_str:
	.asciiz "Hunden, Katten, Glassen"

	.globl DBG
	.text

main:
	addi $sp, $sp, -4	            # PUSH return address
	sw $ra, 0($sp)

	# integer_array_sum
	
	li	$v0, 4
	la	$a0, STR_sum_of_fibonacci_a
	syscall

	lw 	$a0, ARRAY_SIZE
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, STR_sum_of_fibonacci_b
	syscall
	
	la	$a0, FIBONACCI_ARRAY
	lw	$a1, ARRAY_SIZE
	jal  integer_array_sum

	# Print sum
	add	$a0, $v0, $zero
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, NLNL
	syscall
	
	la	$a0, STR_str
	jal	print_test_string

	##
	### string_length 
	##
	
	li	$v0, 4
	la	$a0, STR_string_length
	syscall

	la	$a0, STR_str
	jal 	string_length

	add	$a0, $v0, $zero
	li	$v0, 1
	syscall

	##
	### string_for_each(string, ascii)
	##
	
	li	$v0, 4
	la	$a0, STR_for_each_ascii
	syscall
	
	la	$a0, STR_str
	la	$a1, ascii
	jal	string_for_each

	##
	### string_for_each(string, to_upper)
	##
	
	li	$v0, 4
	la	$a0, STR_for_each_to_upper
	syscall

	la	$a0, STR_str
	la	$a1, to_upper
	jal	string_for_each
	
	la	$a0, STR_str
	jal	print_test_string

	##
	### reverse_string(string)
	##
	
	li	$v0, 4
	la	$a0, STR_reverse_string
	syscall
	
	la	$a0, STR_str
	jal 	reverse_string
	li	$v0, 4
	syscall
		
	lw	$ra, 0($sp)	# POP return address
	addi	$sp, $sp, 4	
	
	li	$v0, 10
	syscall


	
integer_array_sum:

DBG:

    	addi $v0, $zero, 0              # Initialize Sum to zero.
	add  $t0, $zero, $zero	        # Initialize array index i to zero.
	
for_all_in_array:
	
	beq  $t0, $a1, end_for_all      # Done if i == N
	sll  $t1, $t0, 2                # 4*i
    	add  $t2, $a0, $t1              # address = ARRAY + 4*i
	lw  $t3, 0($t2)                 # n = A[i]
       	add $v0, $v0, $t3 		# Sum = Sum + n
        addi $t0, $t0, 1		# i++ 
  	j for_all_in_array              # next element
	
end_for_all:
	
	jr $ra			        # Return to caller.

string_length:

	addi $v0, $zero, 0              # Initialize Sum to zero.
	
	loop: add $t2, $a0, $v0         # address = ARRAY + i
	lb $t3, 0($t2)                  # n = A[i]
	beq $t3, 0, skip1		# Done if i == NULL  
	addi $v0, $v0, 1		# i++   
  	j loop            		# next element
	skip1: jr $ra			# return to caller.
	
string_for_each:

	addi $sp, $sp, -12		# PUSH return address to caller
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	addi $s0, $zero, 0              # Initialize array index i to zero.
	la $s1, ($a0)			# save address to string.
	
	loop2:
	add $a0, $s1, $s0         	# address = ARRAY + i
	lb $t3, 0($a0)                  # n = A[i]
	beq $t3, 0, skip2		# Done if i == (NULL, (0x00)) 
	addi $s0, $s0, 1		# i++ 
	la $ra, loop2			# set return to this function 
	jr $a1				# go to ascii to print
	
	skip2: 
	lw $ra, 0($sp)		        # Pop return address to caller
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12		

	jr $ra

to_upper:

	lb $t0, 0($a0)			# load ascii value
	bgt $t0, 96, next		# check value > 97
	j skip3				# end
	next: ble $t0, 122, next2	# check value <= 122
	j skip3				# end
	next2: lb $t1, 0($a0)		# 
	addi $t2, $t1, -32		# -32 to get upper case value
	sb $t2, 0($a0)			
	skip3:
	jr $ra

reverse_string:
	
	addi $sp, $sp, -8		# PUSH return address to caller
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	la $ra, done_length
	j string_length			# get length of string
	done_length:
	
	addi $s0, $zero, 0              # Initialize array index i to zero. (i = 0)
	subi $t1, $v0, 1		# save length (j = length - 1)
	sra $t2, $t1, 1 		# divide length by 2 
	
	loop3:	

	add $t3, $a0, $s0       	# char[i]
   	lb $t4, 0($t3)            	# temp1 = char[i]
  
  	add $t5, $a0, $t1		# char[j]	
  	lb $t6, 0($t5)            	# temp2 = char[j]

    	sb $t4, 0($t5)            	# char[j] = char[i]
    	sb $t6, 0($t3)            	# char[i] = char[j]

	subi $t1, $t1, 1		# j--
    	addi $s0, $s0, 1        	# i++
    	
    	bge $s0, $t2, end		# exit if (i >= length / 2)
	j loop3				# next element
	
	end:
	
	lw $ra, 0($sp)		        # Pop return address to caller
	lw $s0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	
	.data

NLNL:	.asciiz "\n\n"
	
STR_sum_of_fibonacci_a:	
	.asciiz "The sum of the " 
STR_sum_of_fibonacci_b:
	.asciiz " first Fibonacci numbers is " 

STR_string_length:
	.asciiz	"\n\nstring_length(str) = "

STR_for_each_ascii:	
	.asciiz "\n\nstring_for_each(str, ascii)\n"

STR_for_each_to_upper:
	.asciiz "\n\nstring_for_each(str, to_upper)\n\n"	

STR_reverse_string:
	.asciiz "\n\nreverse_string(str)\n\n"

	.text
	.globl main


print_test_string:	

	.data
STR_str_is:
	.asciiz "str = \""
STR_quote:
	.asciiz "\""	

	.text

	add	$t0, $a0, $zero
	
	li	$v0, 4
	la	$a0, STR_str_is
	syscall

	add	$a0, $t0, $zero
	syscall

	li	$v0, 4	
	la	$a0, STR_quote
	syscall
	
	jr	$ra	

ascii:	
	.data
STR_the_ascii_value_is:
	.asciiz "\nAscii('X') = "

	.text

	la	$t0, STR_the_ascii_value_is

	# Replace X with the input character
	
	add	$t1, $t0, 8	# Position of X
	lb	$t2, 0($a0)	# Get the Ascii value
	sb	$t2, 0($t1)

	# Print "The Ascii value of..."
	
	add	$a0, $t0, $zero 
	li	$v0, 4
	syscall

	# Append the Ascii value
	
	add	$a0, $t2, $zero
	li	$v0, 1
	syscall


	jr	$ra
	
