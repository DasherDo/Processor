module instruction_fields(
	input [23:0]	instruction,
	output [1:0]	Rd, Rs, Rt,
	output [11:0]	immediate,
	output [5:0]	op
);

	/*
	Instruction Format:

	Bits 23 - 18:
		Op, to Control Unit

	Bits 17 - 16:
		Rs

	Bits 15 - 14:
		Rt

	Bits 13 - 12:
		Rd

	Bits 11 - 0:
		Immediate

	*/
	assign op = instruction[23:18];
	assign Rs = instruction[17:16];
	assign Rt = instruction[15:14];
	assign Rd = instruction[13:12];
	assign immediate = instruction[11:0];

endmodule