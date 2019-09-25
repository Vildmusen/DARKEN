	.data
NL:	.asciiz "\n"	
SIZE:	.word 10
ARRAY:	.word 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
        .text
        .globl main
main:   add	$t0, $zero, $zero	# array index i
	la	$t1, ARRAY		
        lw	$t2, SIZE
loop:   beq	$t0, $t2, done		# for e in ARRAY
	sll	$t4, $t0, 2		# offset = 4*i
	add	$t3, $t1, $t4 		# addr = ARRAY + offset
	lw	$a0, 0($t3)		# e =  ARRAY[i] 
       	li	$v0, 1			# print e	
	syscall
	li     	$v0, 4              	# print  \n
        la     	$a0, NL			
	syscall
	
        addi	$t0, $t0, 1		# next element
	
       	j	loop
	
done:  	jr	$ra
