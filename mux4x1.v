module mux4x1 (
	input [0:47] in0, in1, in2, in3,
	input [0:1] select,
	output reg [0:47] out
);

	always @(*) begin
	 	case (select)
		2'b00: out = in0;
		2'b01: out = in1;
		2'b10: out = in2;
		2'b11: out = in3;

		endcase
	end

endmodule