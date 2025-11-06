module instruction_fields(
	input [0:23]	instruction,
	output [0:1]	Rd, Rs, Rt,
	output [0:11]	immediate,
	output [0:5]	op
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
	assign op = instruction[18:23];
	assign Rs = instruction[16:17];
	assign Rt = instruction[14:15];
	assign Rd = instruction[12:13];
	assign immediate = instruction[0:11];

endmodule