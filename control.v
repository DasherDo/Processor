module control (
	input clk, reset,
	input [0:5] op,

	output reg memread, memwrite, alusrca, memtoreg, iord, regwrite, regdest,
	output reg pcen,
	output reg [0:1] pcsource, alusrcb,
	output reg [0:3] aluop,
	output reg [0:3] iwrite
);

	reg [0:3] state, nextstate;
	reg pcwrite, pcwritecond;

	parameter FETCH = 4'b0000;
	parameter DECODE = 4'b0001;
	parameter JUMP = 4'b0010;
	parameter BRANCH = 4'b0011;
	parameter EXECUTION_A = 4'b0100;
	parameter RTYPE = 4'b0101;
	parameter MEMADR = 4'b0110;
	parameter MEMLW = 4'b0111;
	parameter MEMSW = 4'b1000;
	parameter MEMWB = 4'b1001;
	parameter EXECUTION_I = 4'b1010;
	parameter NOP = 4'b1011;

	// Type A Instructions all start with 111xxx
	parameter TYPEA = 3'b111;
	parameter ADD = {TYPEA, 3'b000};
	parameter SUB = {TYPEA, 3'b001};
	parameter XOR = {TYPEA, 3'b010};
	parameter XNOR = {TYPEA, 3'b011};
	parameter AND = {TYPEA, 3'b100};
	parameter OR = {TYPEA, 3'b101};
	parameter NOR = {TYPEA, 3'b110};

	parameter ADDI = 6'b0;
	parameter SUBI = 6'b1;

	parameter LW = 6'b000010;
	parameter SW = 6'b000011;

	parameter BEQ = 6'b000100;
	parameter BLT = 6'b000101;
	parameter BGT = 6'b000110;

	parameter J = 6'b000111;
	parameter EXIT = 6'b001000;

	always @(posedge clk) begin
		if (reset)
			state <= FETCH;
		else
			state <= nextstate;
	end

	// State logic
	always @(*) begin
		case (state)
			FETCH: nextstate = DECODE;
			DECODE: 
				case(op) 
					ADD, SUB, XOR, XNOR, AND, OR, NOR: nextstate = EXECUTION_A;
					ADDI, SUBI:	nextstate = EXECUTION_I;
					SW, LW:	nextstate = MEMADR;
					BEQ, BLT, BGT: nextstate = BRANCH;
					J: nextstate = JUMP;
					EXIT: nextstate = NOP;
					default: nextstate = FETCH;
				endcase
			MEMADR:
				case(op)
					LW: nextstate = MEMLW;
					SW: nextstate = MEMSW;
					default: nextstate = FETCH;
			endcase
			MEMLW: nextstate = MEMWB;
			MEMWB: nextstate = FETCH;
			BRANCH: nextstate = FETCH;
			JUMP: nextstate = FETCH;
			NOP: nextstate = NOP;
			default: nextstate = FETCH;

		endcase
	end

	// Output logic
	always @(*) begin
		// Set all to zero
		memread = 0; memwrite = 0; alusrca = 0; memtoreg = 0;
        iord = 0; regwrite = 0; regdest = 0;
        pcen = 0;
        pcsource = 2'b00; alusrcb = 2'b00; aluop = 2'b00;
        iwrite = 4'b0000;

		case(state)
			FETCH:
				begin
					memread = 1;
					iwrite = 4'b1111;
					alusrcb = 2'b01;
					pcwrite = 1;
					pcen = 1;
				end
			DECODE: alusrcb = 2'b11;
			EXECUTION_A:
				begin
					alusrca = 1;
					alusrcb = 2'b00;
					regwrite = 1;
					regdest = 1;
					case(op)
						ADD: aluop = 4'b0010;
						SUB: aluop = 4'b0110;
						AND: aluop = 4'b0000;
						OR: aluop = 4'b0001;
						XOR, NOR, XNOR: aluop = 4'b1101;
					endcase
				end
			EXECUTION_I:
				begin
					alusrca = 1;
					alusrcb = 2'b10;
					regwrite = 1;
					case(op)
						ADDI: aluop = 2'b00;
						SUBI: aluop = 2'b01;
					endcase
				end
			MEMADR:
				begin
					alusrca = 1;
				alusrcb = 2'b10;
				aluop = 2'b00;
				end
				
			MEMLW:
			begin
				memread = 1;
				iord = 1;
			end
			MEMWB:
			begin
				regwrite = 1;
				memtoreg = 1;
			end
			MEMSW:
			begin
				memwrite = 1;
				iord = 1;
			end
			BRANCH:
			begin
				alusrca = 1;
				alusrcb = 2'b00;
				aluop = 2'b01;
				pcsource = 2'b01;
				pcen = 1;
			end
			JUMP:
			begin
				pcsource = 2'b10;
				pcen = 1;
			end
			NOP:
				pcen = 0;
		endcase
	end
	

	

endmodule;