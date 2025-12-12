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
	wire [0:47] rega, regb, aluresult, alu_mux_a, alu_mux_b;

	wire [0:11] pc = 12'h800;
	wire [0:1] Rd, Rs1, Rs2, write_reg_adr;
	wire [0:11] immediate, memadr;
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
		.a(alu_mux_a),
		.b(alu_mux_b),
		.control(aluop),
		.result(aluresult),
		.zero(zero)
	);

	memory mem(
		.clk(clk),
		.adr(memadr),
		.write_data(aluresult),
		.output_word(rega)
	);

	register_file regfile(
		.read_adr_a(Rs1),
		.read_adr_b(Rs2),
		.write_adr(write_reg_adr),
		.write_data(aluresult),
		.write_en(regwrite),
		.clk(clk),
		.reg_a(rega),
		.reg_b(regb)
	);

	mux2x1 memmux(
		.select(iord),
		.in0(pc),
		.in1(aluresult),
		.out()
	);

	mux2x1 regmux(
		.select(regdst),
		.in0(Rs1),
		.in1(Rs2),
		.out(write_reg_adr)
	);

	mux2x1 alu_a(
		.select(alusrca),
		.in0(pc),
		.in1(rega),
		.out(alu_mux_a)
	);

	mux4x1 alu_b(
		.select(alusrcb),
		.in0(regb),
		.in1(48'h4),
		.in2(),
		.in3(),
		.out(alu_mux_b)
		);

	



endmodule