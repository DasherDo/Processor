module memory (
	input clk, memwrite, memread,
	input [0:11] adr,
	input [0:47] write_data,
	output reg [0:47] output_word
);

	reg [0:7] mem [0:(1 << 10) - 1];
	wire [0:47] word;

	initial begin
		always @(posedge clk)
			if (memwrite) begin
				// Little endian, LSB at lowest mem adr
				// Byte adressing, each adress points to a byte, but the word is 6 bytes, so 6 writes and reads per mem write and read
				mem[adr] <= writedata[0:7];
				mem[adr + 1] <= writedata[8:15];
				mem[adr + 2] <= writedata[16:23];
				mem[adr + 3] <= writedata[24:31];
				mem[adr + 4] <= writedata[32:39];
				mem[adr + 5] <= writedata[40:47];
			end
	end

	always @(*) begin
		if (memread)
		begin
			readdata = {
				mem[adr],
				mem[adr + 1],
				mem[adr + 2],
				mem[adr + 3],
				mem[adr + 4],
				mem[adr + 5]
			};
		end
		else begin
			readdata = 48'b0;
		end
end

endmodule