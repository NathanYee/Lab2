module addresslatch
#(parameter width = 7)
(
input clk,
input [width-1:0]d,
input ce, 
output [width-1:0]q
);
	reg [width-1:0] mem;
	assign q = mem;

	always @(posedge clk) begin
		if (ce == 1) mem = d;
	end
endmodule
