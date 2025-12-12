`include "mux2x1.v"
`include "mux4x1.v"

module mux_tb;
	reg [0:47] in0, in1, in2, in3;
	reg [0:1] select_4x1;
	reg select_2x1;

	wire [0:47] out2, out4;

	mux2x1 mux2(
		.in0(in0),
		.in1(in1),
		.out(out2),
		.select(select_2x1)
	);

	mux4x1 mux4(
		.in0(in0),
		.in1(in1),
		.in2(in2),
		.in3(in3),
		.out(out4),
		.select(select_4x1)
	);

	initial begin
		$monitor("%h, %h, %h, %b", in0, in1, out2, select_2x1);

		in0 = 48'hffffffffffff;
		in1 = 48'h0;
		in2 = 48'h555555555555;
		in3 = 48'haaaaaaaaaaaa;

		select_2x1 = 0;
		#10;

		select_2x1 = 1;
		#10

		$monitor("%h, %h, %h, %h, %h, %b", in0, in1, in2, in3, out4, select_4x1);

		select_4x1 = 0;
		#10;

		select_4x1 = 1;
		#10;

		select_4x1 = 2;
		#10;

		select_4x1 = 3;
		#10
		$finish;


	end


endmodule