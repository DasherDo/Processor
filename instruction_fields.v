module instruction_fields(
	input [0:23]	instruction,
	output [0:1]	Rd, Rs1, Rs2,
	output [0:11]	immediate,
	output [0:5]	op
);

	/*
	Instruction Format:

	Bits 23 - 18:
		Op, to Control Unit

	Bits 17 - 16:
		Rs1

	Bits 15 - 14:
		Rs2

	Bits 13 - 12:
		Rd

	Bits 11 - 0:
		Immediate

	Depending on the Op, the Immediate will be extended to include the information from Rd, Rs2, and Rs2. 

	*/
	assign op = instruction[0:5];
	assign Rs1 = instruction[6:7];
	assign Rs2 = instruction[8:9];
	assign Rd = instruction[10:11];
	assign immediate = instruction[12:23];

endmodule