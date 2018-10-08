//------------------------------------------------------------------------
// Shift Register
//   Parameterized width (in bits)
//   Shift register can operate in two modes:
//      - serial in, parallel out
//      - parallel in, serial out
//------------------------------------------------------------------------

module shiftregister
#(parameter width = 8)
(
input               clk,                // FPGA Clock
input               pclk,  // Edge indicator
input               pload,       // 1 = Load shift reg with parallelDataIn
input  [width-1:0]  pdataIn,     // Load shift reg in parallel
input               sdataIn,       // Load shift reg serially
output [width-1:0]  pdataOut,    // Shift reg data contents
output              sdataOut       // Positive edge synchronized
);

		reg [width-1:0] mem; assign pdataOut = mem; // Make memory, and expose it
		reg pclkWas; // To detect positive edges in pclk
    always @(posedge clk) begin
			if (pclkWas != pclk) begin
				pclkWas <= pclk; // Put in conditional so it executes after condition is checked
				mem <= {mem << 1, sdataIn}; // Move the values left by one, and append sdataIn
			end
			else
				pclkWas <= pclk;
    end
endmodule
