//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`include "shiftregister.v"

module testshiftregister();

    reg             clk;
    reg             pclk;
    reg             pload;
    wire[7:0]       pdataOut;
    wire            sdataOut;
    reg[7:0]        pdataIn;
    reg             sdataIn; 
    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .pclk(pclk),
    		           .pload(pload), 
    		           .pdataIn(pdataIn), 
    		           .sdataIn(sdataIn), 
    		           .pdataOut(pdataOut), 
    		           .sdataOut(sdataOut));
    
    initial begin
			// Clear the shift register so it's in a known state
			clk = 0; pclk = 0;#100
			pdataIn = 8'b00000000;
			pload = 1;
			clk = 1; #100;
			clk = 0; #100;
			// Fron now on, "leave" the clock at 0, so if behaviors don't happen at the rising edge it's visible

			// Test serial in / parallel out
			sdataIn = 1; pclk = 1; #100
			clk = 1; #100; clk = 0; #100;
			clk = 1; #100; clk = 0; #100;
			clk = 1; #100; clk = 0; #100;
			clk = 1; #100; clk = 0; #100;
			// CHECK "Serial in / parallel out", pdataOut, 8'b01001111
			if (pdataOut !== 8'b01001111)
				$display("%s: actually %b, should be %b", "Serial in / parallel out", pdataOut, 8'b01001111);
			#100;
		
		end

endmodule

