`include "addresslatch.v"

module testaddresslatch();

	reg clk;
	reg [6:0] d;
	reg ce;
	wire [6:0] q;

	addresslatch dut(clk, d, ce, q);

	initial begin
		clk = 0; 
		d = 7'b1100110;
		ce = 0;
		clk = 1; #10; clk = 0; 
		if (q != 0) $display("ce doesn't work");
		ce = 1;
		clk = 1; #10; clk = 0; 
		if (q != 7'b1100110) $display("changing value doesn't work");
	end
endmodule
