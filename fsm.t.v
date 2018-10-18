// Tests the finite-state machine, the shift register, and maybe some other things

`include "corelogic.v"

`define TICK clk = 1; #10; clk = 0; #10; clk = 1; #10; clk = 0; #10; clk = 1; #10; clk = 0; #10;
`define ASSERT_1 if (miso != 1) $display("t = %d, miso is 0, should be 1", $time);
`define ASSERT_0 if (miso != 0) $display("t = %d, miso is 1, should be 0", $time);

module testfsm();
	reg clk, sck, cs, mosi, miso;
	wire miso_we, dm_we, sr_we, addr_we;
	wire [7:0] dm_out, sr_contents;
	wire [6:0] dm_addr;

 	corelogic cl(clk, sck, cs, mosi, miso, miso_we);

	initial begin
		$dumpfile("fsm.vcd");
		$dumpvars(0, cl);

		clk = 0; sck = 0; cs = 1; mosi = 0; `TICK;

		cs = 0; `TICK; // First, make sure the data starts out as zeroes

		sck = 0; mosi = 0; `TICK; sck = 1; `TICK; // The address
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;

		sck = 0; mosi = 1; `TICK; sck = 1; `TICK; // Read mode

		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK; // Read the data
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;

		cs = 1; `TICK; cs = 0; `TICK; // Write 0b00110011 to the address

		sck = 0; mosi = 0; `TICK; sck = 1; `TICK; // The address
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;

		sck = 0; mosi = 0; `TICK; sck = 1; `TICK; // Write mode

		sck = 0; mosi = 0; `TICK; sck = 1; `TICK; // Data to write
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;

		cs = 1; `TICK; cs = 0; `TICK; // See if the data is actually there

		sck = 0; mosi = 0; `TICK; sck = 1; `TICK; // The address
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 1; `TICK; sck = 1; `TICK;
		sck = 0; mosi = 0; `TICK; sck = 1; `TICK;

		sck = 0; mosi = 1; `TICK; sck = 1; `TICK; // Read mode

		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK; // Read the data
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_1; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_1; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_0; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_1; sck = 1; `TICK;
		sck = 0; `TICK; `ASSERT_1; sck = 1; `TICK;

		$finish;
	end
endmodule
