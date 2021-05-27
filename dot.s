.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors 반복 횟수 
#   a3 is the stride of v0 
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:

    # Prologue
    lw t0, 0(a0)
	lw t1, 0(a1)
	addi sp sp -20
	sw t2 0(sp)
	sw t4 4(sp)
	sw t6 8(sp)
	sw s8 12(sp)
	sw s9 16(sp)


    addi a2, a2, -1 #length - compare with index
    mul t5, t0,t1
    mv t6, x0 #i
    mv t5, x0 #result
    mv s8, x0
    mv s9, x0
loop_start:
	
	slli t2, t6, 2 # 4i
	mul t0, t2, a3 #4i*S0
	mul t1, t2, a4 #4i*S1
	add t4, a0, t0# V0 + 4i*S0
	add s9, a1, t1 # V1+ 4i*S1
	lw t0, 0(t4)
	lw t1, 0(s9)
	mul s8, t0, t1
	add t5, t5, s8
	beq a2, t6, loop_end
	addi t6, t6, 1


	j loop_start



loop_end:
	
	
	lw t2 0(sp)
	lw t4 4(sp)
	lw t6 8(sp)
	lw s8 12(sp)
	lw s9 16(sp)
	addi sp sp 20

	mv a0, t5
    ret
    
    
