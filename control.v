module control (
	input clk, reset,
	input [5:0] op,

	output reg memread, memwrite, alusrca, memtoreg, iord, regwrite, regdest,
	output pcen,
	output reg [1:0] pcsource, alusrcb, aluop,
	output reg [3:0] iwrite
);

	reg [3:0] state, nextstate;

	initial begin
		memread <= (state == 4'b0000 || state == 4'b0011) ? 1 : 0;
		memwrite <= (state == 4'b0101) ? 1 : 0;
		alusrca <= (state == 4'b0010 || state == 4'b0110 || state == 4'b1000) ? 1 : 0;
		memtoreg <= (state == 4'b0100) ? 1 : 0;
		iord <= (state == 4'b0011 || state == 4'b0101) ? 1 : 0;
		regwrite <= (state == 4'b0100 || state == 4'b0111) ? 1 : 0;
		regdest <= (state == 4'b0111) ? 1 : 0;
	end
	

	

endmodule;