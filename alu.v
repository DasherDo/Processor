module alu (
	input [0:47] a,
	input [0:47] b,
	input [0:3] control,
	input wire clk,

	output reg [0:47] result,
	output zero
);

	always @(posedge clk) begin
		if (control === 4'h0)  					// and
			result <= a & b;
		else if (control === 4'h1)
			result <= a | b;					// Or
		else if (control === 4'h2)
			result <= a + b;						// Add
		else if (control === 4'h6)
			result <= a - b;						// Sub
		else if (control === 4'h7)
			result <= (a < b) ? 48'h1 : 48'h0;	// Slt
		else if (control === 4'hc)
			result <= a ~| b;					// Nor
	end


endmodule