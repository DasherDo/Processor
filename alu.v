module alu (
	input signed [47:0] a,
	input signed [47:0] b,
	input [3:0] control,

	output reg signed [47:0] result,
	output zero
);

	always @(*) begin
		if (control == 4'h0)  					// and
			result <= a & b;
		else if (control == 4'h1)
			result <= a | b;					// Or
		else if (control == 4'h2)
			result <= a + b;						// Add
		else if (control == 4'h6)
			result <= a - b;						// Sub
		else if (control == 4'h7)
			result <= (a < b) ? 48'sh1 : 48'sh0;	// Slt
		else if (control == 4'hc)
			result <= a ~| b;					// Nor


	end

	assign zero = (result == 48'sh0);
	



endmodule