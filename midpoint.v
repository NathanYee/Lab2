//------------------------------------------------------------------------
// Midpoint Check In
//    1) The parallel data input of the shift register is tied to a constant value
//    2) The load is triggered when button 0 is pressed
//    3) Switches 0 and 1 allow manual control of the serial input
//    4) LEDs show the state of the shift register
//------------------------------------------------------------------------

`include "inputconditioner.v"
`include "shiftregister.v"

module hw_wrapper(
	input clk,
	input [3:0] sw,
	input [3:0] btn,
	output [3:0] led
);
	
	midpoint device(clk, btn[0], 8'hA5, sw[1], sw[0], led);
endmodule


module midpoint(
	input clk,
	input pLoad,
	input [7:0] pdataIn,
	input shift,
	input sdataIn,
	output [3:0] leds
);
	
	wire pLoadClean, sdataInClean, shiftEdge;
	wire [7:0] ledsFull;

	inputconditioner cond1(clk, pLoad, pLoadClean, , );
	inputconditioner cond2(clk, sdataIn, sdataInClean, , );
	inputconditioner cond3(clk, shift, , shiftEdge, );

	shiftregister #(8) sr1(clk, shiftEdge, pLoadClean, pdataIn, sdataInClean, ledsFull, );
	assign leds = ledsFull[7:0];

endmodule
