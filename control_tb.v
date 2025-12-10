`include "control.v"

module control_tb;

    reg clk;
    reg reset;
    reg [0:5] op;

    wire memread, memwrite, alusrca, memtoreg, iord, regwrite, regdest;
    wire pcen;
    wire [0:1] pcsource, alusrcb;
	wire [0:3] aluop;
    wire [0:3] iwrite;

    control dut (
        .clk(clk),
        .reset(reset),
        .op(op),
        .memread(memread),
        .memwrite(memwrite),
        .alusrca(alusrca),
        .memtoreg(memtoreg),
        .iord(iord),
        .regwrite(regwrite),
        .regdest(regdest),
        .pcen(pcen),
        .pcsource(pcsource),
        .alusrcb(alusrcb),
        .aluop(aluop),
        .iwrite(iwrite)
    );

	parameter TYPEA = 3'b111;
	parameter ADD = {TYPEA, 3'b000};
	parameter SUB = {TYPEA, 3'b001};
	parameter XOR = {TYPEA, 3'b010};
	parameter XNOR = {TYPEA, 3'b011};
	parameter AND = {TYPEA, 3'b100};
	parameter OR = {TYPEA, 3'b101};
	parameter NOR = {TYPEA, 3'b110};

	parameter ADDI = 6'b0;
	parameter SUBI = 6'b1;

	parameter LW = 6'b000010;
	parameter SW = 6'b000011;

	parameter BEQ = 6'b000100;
	parameter BLT = 6'b000101;
	parameter BGT = 6'b000110;

	parameter J = 6'b000111;
	parameter EXIT = 6'b001000;

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

	// Makes setting op codes easier, waits for clock to set and reset the op code aswell
	task apply_op(input [0:5] opcode);
        begin
            op = opcode;
            @(posedge clk);
			op = 6'b0;
            @(posedge clk);
        end
    endtask

    // Monitor outputs
    initial begin
        $display("Time | State | Opcode");
        $monitor("%4t | %b | %b",
                 $time, dut.state, op);
    end

    // Test sequence
    initial begin
        reset = 1;
        op = 6'b0;
        #10;
        reset = 0;
		
		// Time to let every state cycle finish before applying the next op code
		$display("ADD");
		apply_op(ADD);		#20;
		$display("SUB");
		apply_op(SUB);		#20;
		$display("XOR");
		apply_op(XOR);		#20;
		$display("XNOR");
		apply_op(XNOR);		#20;
		$display("AND");
		apply_op(AND);		#20;
		$display("OR");
		apply_op(OR);		#20;
		$display("NOR");
		apply_op(NOR);		#20;

		$display("ADDI");
		apply_op(ADDI);		#20;
		$display("SUBI");
		apply_op(SUBI);		#20;

		$display("LW");
		apply_op(LW);		#20;
		$display("SW");
		apply_op(SW);		#20;

		$display("BEQ");
		apply_op(BEQ);		#20;
		$display("BLT");
		apply_op(BLT);		#20;
		$display("BGT");
		apply_op(BGT);		#20;

		$display("JUMP");
		apply_op(J);		#20;
		$display("EXIT");
		apply_op(EXIT);		#20;

        // Finish
        $display("\nSimulation complete.");
        #20;
        $finish;
    end

endmodule
