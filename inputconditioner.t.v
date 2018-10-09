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
			// $monitor("t=%d, pin=%d, conditioned=%d, rising=%d, falling=%d", $time, pin, conditioned, rising, falling);
			
			pin = 0; #100

            // Synchronization & Edge Detection test
			pin = 1; #85 // stop pin 5 units of time before lower half clock cycle finishes
            pin = 0; #5 // turn pin off and wait 5 units of time for clock cycle to finish
            pin = 0; #20 // wait a complete clock cycle
            $display("t=%d, conditioned=%d, risingEdge=%d", $time, conditioned, rising);
            pin = 0; #1 // conditioned should turn after with rising edge 
            $display("t=%d, conditioned=%d, risingEdge=%d", $time, conditioned, rising);
			pin = 0; #79 // conditioned should be on right before falling edge
            $display("t=%d, conditioned=%d, fallingEdge=%d", $time, conditioned, falling);
			pin = 0; #1 // conditioned shoudl turn off with falling edge
            $display("t=%d, conditioned=%d, fallingEdge=%d", $time, conditioned, falling);

            // Debouncing
            pin = 0; #100 // let signal reset

            pin = 1; #10 // input bouncy signal
            pin = 0; #5
            pin = 1; #13
            pin = 0; #15
            pin = 1; #7
            pin = 0; #9
            pin = 1; #8
            pin = 0; #4
            pin = 1; #12
            pin = 0; #19
            pin = 1; #10
            pin = 0; #11
            pin = 1; #6
            pin = 0; #14
            pin = 1; #8
            pin = 0; #9
            pin = 1; #2
            pin = 0; #3
            pin = 1; #4
            pin = 0; #5
            pin = 1; #17
            pin = 0; #16
            pin = 1; #10
            pin = 0; #10
            pin = 1; #10
            pin = 0; #10
            pin = 1; #10
            pin = 0; #10


			$finish;
		end
    
endmodule
