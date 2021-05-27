.globl relu

.text

relu:
    # Prologue
    slli a1, a1, 2
    add t2, a0, a1

loop_start:
   	bge a0, t2, loop_end
	lw t1, 0(a0)
	j loop_continue



loop_continue:
	bge t1, x0, big
	bge x0, t1, low

big:
	addi a0, a0, 4
	j loop_start
low:
	sw x0, 0(a0)
	addi a0, a0, 4
	j loop_start

loop_end:
    # Epilogue

    
	ret
