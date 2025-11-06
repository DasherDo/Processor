module register_file (
	input [0:1] 	read_adr_a,
	input [0:1] 	read_adr_b,
	input [0:1] 	write_adr,
	input [0:47]	write_data,
	input 			write_en,
	input			clk,

	output wire [0:47] 	reg_a,
	output wire [0:47] 	reg_b
);

	reg [0:47] reg_file [0:3];	// 4 registers, 48 bits wide

	assign reg_a = reg_file[read_adr_a];
	assign reg_b = reg_file[read_adr_b];

	// Write always happens after read, in case one of read registers is going to be written to
	always @(posedge clk) begin
		if (write_en)
			reg_file[write_adr] <= write_data;
	end



endmodule