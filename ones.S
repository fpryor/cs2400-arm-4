		;		ARM Programming Assignment #4: Count the ones in a binary number
		;
		;		Write a program that counts the number of ones in a binary number,
		;       stored in a word (4 bytes). Its loop should run no more times than there
		;       are ones in the number. Write the count in `numones`. For the example
		;       number given below, the loop should only run 8 times, counting 8 ones.
		;
		;       Hint:
		;       The first significant instruction in the loop is SUB r1, r1, 1, which
		;       decrements the number, assuming it's stored in register r1. Now,
		;       remember your logical operations.
		;
		;       Bonus:
		;       1. (20 extra points) For the shortest program (by instruction count),
		;          because this operation has to be FAST.
		;       2. (30 extra points) For extending the program to counting the ones
		;          in any word-aligned contiguous region of memory.

		;		Your code here

ADR		r0, example
		ADR		r1, numones
		LDR		r3, [r0]
		MOV		r4, r3

loop
		sub		r3, r3, #1
		AND		r4, r4, r3
		MOV		r3, r4
		ADD		r5, r5, #1
		CMP		r3, #0
		beq		stop
		b		loop

stop
		STR		r5, [r1]
		end









example	DCD		0x0010070f
numones	FILL		4


