.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:
	
	addi t0, x0, 1 
	mv t4, x0
    lw t1, 0(a0)
    slli a1, a1, 2
    add t3, a0, a1 #최대 index

loop_start:
	
	slli t2, t0, 2 # 4i
	add a2, a0, t2 # a+ 4i
	bge a2, t3, loop_end
	lw a3, 0(a2) 
	j loop_continue


loop_continue:

	blt t1, a3, a3_bigger
	blt a3, t1, t1_bigger
	beq a3, t1, same
a3_bigger:

	srli t2, t2, 2
	mv t4, t2
	mv t1, a3
	addi t0, t0, 1
	j loop_start

t1_bigger:
	addi t0, t0, 1
	j loop_start

same :
	addi t0, t0, 1
	j loop_start

loop_end:
    
    mv a0, t4

    # Epilogue


    ret
