	.data
	
STR:	.asciiz	"abcdefghijklmnopqrstuvxyz"

	.text
	.globl	main

main:	la	$t0, STR
	lw	$t1, 0($t0)

	lb	$t2, 0($t0)
	lb	$t3, 1($t0)
	lb	$t4, 2($t0)
	lb	$t5, 3($t0)	
	
	jr	$ra
