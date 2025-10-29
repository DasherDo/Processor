`include "register_file.v"

module register_file_tb;

	reg clk, write_en;
	reg [1:0] read_adr_a, read_adr_b, write_adr;
	reg [47:0] write_data;

	wire [47:0] reg_a, reg_b;

	register_file dut(
		.clk(clk),
		.write_en(write_en),
		.read_adr_a(read_adr_a),
		.read_adr_b(read_adr_b),
		.write_adr(write_adr),
		.write_data(write_data),
		.reg_a(reg_a),
		.reg_b(reg_b)
	);

	parameter half_clk_period = 5;


	// Clock generation
	initial begin
		clk = 0;
		forever begin
			#5;
			clk = ~clk;
		end
	end

	initial begin
		$monitor("%t, a = %h, b = %h\n", $time, reg_a, reg_b);

		// Writing all registers
		write_en = 1;
		write_adr = 2'b00;
		write_data = 48'h1;
		#10;

		write_adr = 2'b01;
		write_data = 48'h2;
		#10;

		write_adr = 2'b10;
		write_data = 48'h3;
		#10;

		write_adr = 2'b11;
		write_data = 48'h4;
		#10;

		// Read registers
		write_en = 0;
		read_adr_a = 2'b00;
		read_adr_b = 2'b01;
		#10;

		read_adr_a = 2'b10;
		read_adr_b = 2'b11;
		#11;

		$finish;

	end



endmodule