`include "alu.v"

module alu_tb;

	reg signed [47:0] a, b;
	reg [3:0] control;
	reg clk;
	wire signed [47:0] result;
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
		$monitor("%t, A = %d, B = %d, control = %h, result = %d, zero = %b", $time, a, b, control, result, zero);
		a = 48'hAAAA_AAAA_AAAA; b = 48'h5555_5555_5555; control = 4'h0;
    #10;

    // OR test
    a = 48'h0; b = 48'hFFFF_FFFF_FFFF; control = 4'h1;
    #10;

    // ADD test
    a = 48'h1; b = 48'h1; control = 4'h2;
    #10;

    // SUB test
    a = 48'd10; b = 48'd5; control = 4'h6;
    #10;

    // SLT test
    a = 48'd3; b = 48'd5; control = 4'h7;
    #10;

    // NOR test
    a = 48'hAAAA_AAAA_AAAA; b = 48'h5555_5555_5555; control = 4'hC;
    #10;
		$finish;

	end


endmodule