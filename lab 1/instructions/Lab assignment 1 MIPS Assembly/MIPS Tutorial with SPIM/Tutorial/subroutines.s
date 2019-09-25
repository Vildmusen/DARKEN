	.data
	
X:	.word 0x11111111
Y:	.word 0x22222222
	
	.text
        .globl main
	
main:	la	$a0, X		# Address of X
	li	$a1, 127	# a = 127
	li	$a2, 0xa	# b = 0xa = 10 (decimal)
	jal 	addm		# store s =  a + b in memory at address X

	la	$a0, Y		# Address of Y
	add	$a1, $v0,$zero 	# a = s
	li	$a2, -3		# b = -3
	jal 	addm		# store a + b in memory at address Y

	nop

	jr	$ra

##############################################################################
#
#  DESCRIPTION: Calculate the sum S = A + B and store the result
#		to memory location M.
#
#        INPUT: $a0 - M (address)
# 	        $a1 - A (integer)
#		$a2 - B (integer)
#
#       OUTPUT: $v0 - S (integer)
#
# SIDE EFFECTS: The the sum S is written to the memory location M.
#	
###############################################################################
addm:
	add 	$v0, $a1, $a2		# S = A + B
	sw	$v0, 0($a0)		# Store S to memory at address M

	jr	$ra			# Return to caller
	
