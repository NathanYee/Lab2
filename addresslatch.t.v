`include "addresslatch.v"

module testaddresslatch();

	reg clk;
	reg [7:0] d;
	reg ce;
	wire [7:0] q;

	addresslatch dut(clk, d, ce, q);

	initial begin
		clk = 0; 
		d = 8'b11001100;
		ce = 0;
		clk = 1; #10; clk = 0; 
		if (q != 0) $display("ce doesn't work");
		ce = 1;
		clk = 1; #10; clk = 0; 
		if (q != 8'b11001100) $display("changing value doesn't work");
	end
endmodule
