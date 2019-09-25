	.data
x:	.word 5
y:	.word 3
z:	.space 8	

	.text
        	.globl main
main:	la	$t0, x
	lw	$t1, 0($t0)

	lw	$t2, y	# pseudo-instruction

	add	$t3, $t1, $t2

	la	$t4, z
	sw	$t3, 0($t4)
	sw	$t2, 4($t4)

		
	jr	$ra
