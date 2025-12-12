module mux2x1 (
	input select,
	input [0:47] in0, in1,
	output [0:47] out
);

	assign out = select ? in1 : in0;

endmodule