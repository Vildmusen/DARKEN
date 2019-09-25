	.text

        .globl main

main: 
	addi	$t0, $zero, 3	# a = 3
	addi	$t1, $zero, 2	# b = 2

	add	$t2, $t0, $t1	# c = a + b

	seq	$t3, $t0, $t1	# d = 1 iff a == b else d = 0
	seq	$t4, $t0, $t0	# e = 1 iff a == a (sic)
	
	jr	$ra		# return to caller
