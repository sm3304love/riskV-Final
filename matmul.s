.globl matmul

.text

matmul:

    # Error if mismatched dimensions
	bne a2, a4, mismatched_dimensions

	addi sp, sp, -64
	sw ra, 20(sp)

	sw s1 52(sp)
	sw s0 24(sp)
	sw s3 28(sp)
	sw s2 32(sp)
	sw s4 36(sp)
	sw s5 40(sp)
	sw s6 44(sp)
	sw s7 48(sp)
    	sw s8 56(sp)
    	sw s9 60(sp)
	

	mv s0 x0	#index of mat cals rows i # s0 ~ s10 stack
	mv s3 x0	#index of mat 2 row k
	mv s2 x0     	# length * 4 * i 
	mv s4 x0    	# a0 update
	mv s5 x0    	# 4 * k
	mv s6 x0	# a3 update
	mv s7 x0

	


outer_loop_start:
       	
   beq s0, a1, outer_loop_end    	
   slli s2, s0, 2 # 4 * i
   mul s2, s2, a1 # 4 * cols * i
   add s4, a0, s2 # a0 + cols * 4 * i

inner_loop_start:
	
	beq a5, s3, inner_loop_end
	slli s5, s3, 2 # 4 * k
	add s6, a3, s5 # a3 + 4 * k
	
	##lw s7 0(s6)
	##sw s7 0(a6)
	sw a0 0(sp)
	sw a1 4(sp)
	sw a2 8(sp)
	sw a3 12(sp)
	sw a4 16(sp)
     
    	mv a0, s4
    	mv a1, s6
    	mv a2, a2
    	addi a3, x0, 1
    	mv a4 a5

	jal ra dot 
	# dot product result = a0
	sw a0 0(a6)

	addi s3, s3, 1 # k ++
	addi a6, a6, 4

	lw a0 0(sp)
	lw a1 4(sp)
	lw a2 8(sp)
	lw a3 12(sp)
	lw a4 16(sp)

	j inner_loop_start

inner_loop_end:
	mv s3, x0
	addi s0, s0, 1
	j outer_loop_start
    

outer_loop_end:

	mul s7, a1, a5
	slli s7, s7, 2
	li s1, -1
	mul s7, s7, s1
	add a6, a6, s7
	lw ra, 20(sp)
	lw s0 24(sp)
	lw s3 28(sp)
	lw s2 32(sp)
	lw s4 36(sp)
	lw s5 40(sp)
	lw s6 44(sp)
	lw s7 48(sp)
    	lw s8 54(sp)
    	lw s9 60(sp)
	
	lw s1 52(sp)
	addi sp, sp, 64
	
	ret
	
mismatched_dimensions:
    addi a1,a1 2
    
    jal exit2
