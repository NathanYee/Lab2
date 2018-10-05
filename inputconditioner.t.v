//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------
`include "inputconditioner.v"

module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;
    
    inputconditioner dut(.clk(clk),
    			 .noisysignal(pin),
			 .conditioned(conditioned),
			 .positiveedge(rising),
			 .negativeedge(falling));


    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
    
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronization, Debouncing, Edge Detection

    initial begin
			$dumpfile("inputconditioner.vcd");
			$dumpvars(0, dut);
			$monitor("t=%d, pin=%d, conditioned=%d, rising=%d, falling=%d", $time, pin, conditioned, rising, falling);
			

			pin = 1; #100


			$finish;
		end
    
endmodule
