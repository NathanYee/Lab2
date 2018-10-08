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
		assign sdataOut = pdataOut[width-1]; // Expose the MSB as "serial out"
		reg pclkWas; // To detect positive edges in pclk

		// Note that there exists a sort of race condition here.  What happens if pclk has an edge while pload is
		// set?  The answer is undefined; don't do it.
    always @(posedge clk) begin

			// Peripheral clock; or, putting the "shift" in "shift register"
			if ((pclkWas == 0) && (pclk == 1)) begin
				pclkWas <= pclk; // Put in conditional so it executes after condition is checked
				// $display("Left shift, bringing in %b", sdataIn);
				mem <= {mem, sdataIn}; // Move the values left by one, and append sdataIn (silently dropping MSB)
			end
			else
				pclkWas <= pclk;

			// Parallel loading
			if (pload == 1) 
				mem <= pdataIn;

    end
endmodule
