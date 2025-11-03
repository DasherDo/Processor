`include "instruction_fields.v"

module instruction_fields_tb;

	reg [23:0] instruction;
	wire [1:0] Rd, Rs, Rt;
	wire [5:0] op;
	wire [11:0] immediate;

	instruction_fields dut(
		.instruction(instruction),
		.Rd(Rd),
		.Rs(Rs),
		.Rt(Rt),
		.op(op),
		.immediate(immediate)
	);

	initial begin
		$monitor("%b, %b, %b, %b, %b, %b", instruction, Rd, Rs, Rt, op, immediate);
		instruction = 24'b010100001100101010101010;
		#10;

		instruction = 24'h000000;
		#10;

	end

endmodule;