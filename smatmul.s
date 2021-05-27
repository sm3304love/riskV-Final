.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:

	bne a2 a4 mismatched_dimensions
	
	li t0 0		#index of mat 1 rows
	li t1 0		#index of mat 1 cols
	li t3 0		#index of mat 2 cols
	li t2 0
	li t4 0
	li t5 0
	li t6 0

outer_loop_start:
	
	mul t4 t0 a2

inner_loop_start:

	add t5 t4 t1
	slli t5 t5 2
	add t5 t5 a0
	lw t5 0(t5)
	
	mul t6 t1 a5
	add t6 t6 t3
	slli t6 t6 2
	add t6 t6 a3
	lw t6 0(t6)

	mul t5 t5 t6
	add t2 t2 t5
	
	addi t1 t1 1
	bne t1 a4 inner_loop_start
	
	sw t2 0(a6)
	addi a6 a6 4

	addi t3 t3 1
	li t2 0
	li t1 0
	bne t3 a5 inner_loop_start

inner_loop_end:

	li t3 0
	addi t0 t0 1
	bne t0 a1 outer_loop_start

outer_loop_end:
	
	mul t0 a1 a5
	slli t0 t0 2
	li t1 -1
	mul t0 t0 t1
	add a6 a6 t0

    ret

 
mismatched_dimensions:
    li a1 2
    jal exit2
