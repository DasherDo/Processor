`include "control.v"
`include "alu.v"
`include "mux2x1.v"
`include "mux4x1.v"
`include "memory.v"
`include "instruction_fields.v"

module mips(
	input clk, reset,
	input [0:47] memdata,
	output memread, memwrite,
	output [0:47] adr, writedata
);

	wire [0:23] instruction;
	wire zero, alusrca, memtoreg, iord, pcen, regwrite, regdst;
	wire [0:1] pcsource, alusrcb;
	wire [0:3] aluop, iwrite;
	wire [0:47] rega, regb, aluresult;

	wire [0:11] pc = 12'h800;
	wire [0:1] Rd, Rs1, Rs2;
	wire [0:11] immediate;
	wire [0:5] op;

	instruction_fields instruction(
		.instruction(instruction),
		.Rd(Rd),
		.Rs1(Rs1),
		.Rs2(Rs2),
		.immediate(immediate),
		.op(op)
	);

	control cont(
			.clk(clk),
			.reset(reset),
			.op(op),
			.memread(memread),
			.memwrite(memwrite),
			.alusrca(alusrca),
			.memtoreg(memtoreg),
			.iord(iord),
			.regwrite(regwrite),
			.regdest(regdst),
			.pcen(pcen),
			.pcsource(pcsource),
			.alusrcb(alusrcb),
			.aluop(aluop),
			.iwrite(iwrite)
	);

	alu alu(
		.a(rega),
		.b(regb),
		.control(aluop),
		.result(aluresult),
		.zero(zero)
	);

	memory mem(
		.clk(clk),
		.adr(immediate),
		.write_data(aluresult),
		.output_word(rega)
	);

	register_file regfile(
		.read_adr_a(Rs1),
		.read_adr_b(Rs2),
		.write_adr(Rd),
		.write_data(aluresult),
		.write_en(),
		.clk(clk),
		.reg_a(rega),
		.reg_b(regb)
	);

	mux2x1 regmux(
		.select(regdst),
		.in0()
	)


endmodule