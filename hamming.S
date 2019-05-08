		;		ARM Programming Assignment #4: Encode in Hamming(15, 11)
		;
		;		Write a subroutine that encodes 11 bits of data into a 15-bit
		;       block, using 4 parity bits. Assume even parity, that is,
		;       the parity of the bits covered by a parity bit, including
		;       the parity bit, has to be an even number. Assume the bits are
		;       written in the following sequence: p1, p2, d1, p4, d2, d3, d4,
		;       p8, d5, d6, d7, d8, d9, d10, d11, p16, d12, d13, d14, d15.
		;       Call the subroutine `hencode`.
		;
		;       Write a subroutine that decodes a H(15, 11) block to extract
		;       the 11 data bits. Call it `hdecode`. It should:
		;       - calculate the correcting code
		;       - dentify the case: no error (noer), one-bit error (onee)
		;       - write the result in `case` using the encoding provided
		;       - if there is a one-bit error, write the number of the
		;         erroneous bit in `berr`
		;       - if there is a one-bit error, correct the data
		;       - write the result in `corr`
		;
		;       Now, write a main function which uses `hencode` and `decode`
		;       to encode `data` and then, after a simulated transmission,
		;       decode `recv`. Assume that `recv` contains what is received
		;       at the other end.

		;		Your code here
		;       I tried and tried for weeks but I couldn't get the decode program to work..
		;       it took me forever but I got hencode running, and I'm kinda proud of it :)
		;       counting bits from right to left


hencode
        ADR		r0, data
		LDR		r1, [r0]

		MOV		r2, r1, LSR #4		;isolate d11 thru d5
		LSL		r2, r2, #8			;expand 11 bits to 15
		AND		r3, r1, #0xE		;isolate d4 thru d2
		ADD		r2, r2, r3, LSL #3	;add these bits, room for p8, p4
		AND		r3, r1, #1			;isolate d1
		ADD		r2, r2, r3, LSL #2	;add this bit, room for p2, p1
		;now		11 bit data is 15, parity bits zero


		;generate	p1
		ADR		r6, pone
		LDR		r7, [r6]
		AND		r3, r2, r7
		MOV		r4, r3				;duplicate the number
one
		sub		r3, r3, #1 		    ;decrement the number
		AND		r4, r4, r3 		    ;compare original number to decremented number
		MOV		r3, r4      		;AND result become new number
		ADD		r5, r5, #1  		;adds one to the count
		CMP		r3, #0
		bne		one
		AND		r5, r5, #1
		ADD		r2, r2, r5
		MOV		r5, #0	            ;reset ones counter

		;generate	p2
		ADR		r6, ptwo
		LDR		r7, [r6]
		AND		r3, r2, r7
		MOV		r4, r3		        ;duplicate the number

two
		sub		r3, r3, #1          ;decrement the number
		AND		r4, r4, r3          ;compare original number to decremented number
		MOV		r3, r4              ;AND result become new number
		ADD		r5, r5, #1          ;adds one to the count
		CMP		r3, #0
		bne		two
		AND		r5, r5, #1
		ADD		r2, r2, r5, LSL #1
		MOV		r5, #0	            ;reset ones counter

		;generate	p4
		ADR		r6, pfour
		LDR		r7, [r6]
		AND		r3, r2, r7
		MOV		r4, r3		        ;duplicate the number

four
		sub		r3, r3, #1          ;decrement the number
		AND		r4, r4, r3          ;compare original number to decremented number
		MOV		r3, r4              ;AND result become new number
		ADD		r5, r5, #1          ;adds one to the count
		CMP		r3, #0
		bne		four
		AND		r5, r5, #1
		ADD		r2, r2, r5, LSL #3
		MOV		r5, #0	            ;reset ones counter

		;generate	p8
		ADR		r6, peight
		LDR		r7, [r6]
		AND		r3, r2, r7
		MOV		r4, r3		        ;duplicate the number

eight
		sub		r3, r3, #1          ;decrement the number
		AND		r4, r4, r3          ;compare original number to decremented number
		MOV		r3, r4              ;AND result become new number
		ADD		r5, r5, #1          ;adds one to the count
		CMP		r3, #0
		bne		eight
		AND		r5, r5, #1
		ADD		r2, r2, r5, LSL #7
		MOV		r5, #0	            ;reset ones counter

		;store decoded number to send
		ADR		r0, send
		STR		r2, [r0]

data		DCD		0b10100100101
pone		DCD		0x5554
ptwo		DCD		0x6664
pfour		DCD		0x7870
peight	    DCD		0x7F00
send		FILL	4




recv    DCD     0b101111010100101
noer    DCD     0x00
onee    DCD     0x01
case    FILL    4
berr    FILL    4
corr    FILL    4