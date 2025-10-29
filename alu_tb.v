`include "alu.v"

module alu_tb;

	reg signed [47:0] a, b;
	reg [3:0] control;
	wire signed [47:0] result;
	wire zero;

	alu dut(
		.a (a),
		.b (b),
		.control (control),
		.result (result),
		.zero (zero));

	initial begin
		$monitor("A = %h, B = %h, control = %h, result = %h, zero = %b\n", a, b, control, result, zero);

		// AND TEST
		$display("Expected: 000000000000");
		a = 48'hAAAA_AAAA_AAAA; b = 48'h5555_5555_5555; control = 4'h0;
		#10;

		$display("Expected: 555555555555");
		a = 48'hFFFF_FFFF_FFFF; b = 48'h5555_5555_5555; control = 4'h0;
		#10;

		$display("Expected: ffffffffffff");
		a = 48'hFFFF_FFFF_FFFF; b = 48'hFFFF_FFFF_FFFF; control = 4'h0;
		#10;


		// OR test
		$display("Expected: ffffffffffff");
		a = 48'h0; b = 48'hFFFF_FFFF_FFFF; control = 4'h1;
		#10;
		
		$display("Expected: ffffffffffff");
		a = 48'h5555_5555_5555; b = 48'hAAAA_AAAA_AAAA;
		#10;

		$display("Expected: ffffffffffff");		
		a = 48'hFFFF_FFFF_FFFF; b = 48'hFFFF_FFFF_FFFF; 
		#10;

		// ADD test
		$display("Expected: 000000000002");
		a = 48'h1; b = 48'h1; control = 4'h2;
		#10;

		$display("Expected: ffffffffffff");	
		a = 48'h0; b = 48'hFFFF_FFFF_FFFF;
		#10;

		$display("Expected: ffffffffffff");	
		a = 48'h5555_5555_5555; b = 48'hAAAA_AAAA_AAAA;
		#10;

		$display("Expected: fffffffffffe");	
		a = 48'hFFFF_FFFF_FFFF; b = 48'hFFFF_FFFF_FFFF; 
		#10;

		$display("Expected: 000000000000, zero = 1");
		a = -48'd16; b = 48'd16;
		#10;

		$display("Expected: fffffffffff1");
		a = -48'd10; b = -48'd5;
		#10;

		// SUB test
		$display("Expected: 000000000005");
		a = 48'd10; b = 48'd5; control = 4'h6;
		#10;

		$display("Expected: 000000000000, zero = 1");
		a = 48'h1; b = 48'h1;
		#10;

		$display("Expected: 000000000001");
		a = 48'h0; b = 48'hFFFF_FFFF_FFFF;
		#10;

		$display("Expected: aaaaaaaaaaab");
		a = 48'h5555_5555_5555; b = 48'hAAAA_AAAA_AAAA;
		#10;

		$display("Expected: 000000000000, zero = 1");
		a = 48'hFFFF_FFFF_FFFF; b = 48'hFFFF_FFFF_FFFF; 
		#10;

		$display("Expected: ffffffffffe0");
		a = -48'd16; b = 48'd16;
		#10;

		$display("Expected: fffffffffffb");
		a = -48'd10; b = -48'd5;
		#10;

		// SLT test
		$display("Expected: 1");
		a = 48'd3; b = 48'd5; control = 4'h7;
		#10;

		$display("Expected: 0, zero = 1");
		a = -48'd3; b = -48'd5; control = 4'h7;
		#10;

		$display("Expected: 0, zero = 1");
		a = 48'd9; b = -48'd5; control = 4'h7;
		#10;

		$display("Expected: 0, zero = 1");
		a = 48'd5; b = 48'd5; control = 4'h7;
		#10;

		$display("Expected: 1");
		a = 48'd0; b = 48'd9; control = 4'h7;
		#10;


		// NOR test
		$display("Expected: 000000000000, zero = 1");
		control = 4'hC; a = 48'hAAAA_AAAA_AAAA; b = 48'h5555_5555_5555;
		#10;

		$display("Expected: ffffffffffff");
		a = 48'h0; b = 48'h0;
		#10;
		$finish;

	end


endmodule