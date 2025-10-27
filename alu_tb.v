`include "alu.v"

module alu_tb;

	reg [0:47] a, b;
	reg [0:3] control;
	reg clk;
	wire [0:47] result;
	wire zero;

	alu dut(
		.a (a),
		.b (b),
		.control (control),
		.clk (clk),
		.result (result),
		.zero (zero));

	parameter clk_period = 10;
	parameter half_clk_period = clk_period / 2;

	// Clock generation
	initial begin 
		clk = 0;
		forever begin
			# (half_clk_period) clk = ~clk;
		end
	end


	initial begin
		$monitor("%t, A = %b, B = %b, control = %b, result = %b, zero = %b", $time, a, b, control, result, zero);
		a <= 'hffffffffffff;
		b <= 'hffffffffffff;
		control <= 4'h0;
		#10
		a <= 48'h0;
		#10;

	end


endmodule