// The logic of the SPI memory
// Everything except the input conditioners and tri-state buffer
// (unfortunately, "logic" is a reserved word)

`include "finitestatemachine.v"
`include "shiftregister.v"
`include "datamemory.v"
`include "addresslatch.v"

module corelogic
(
	input clk, sck, cs, mosi,
	output miso, miso_we
);

	wire miso_we, dm_we, sr_we, addr_we;
	wire [7:0] dm_out, sr_contents;
	wire [6:0] dm_addr;

	finitestatemachine fsm(clk, sck, cs, mosi, miso_we, dm_we, addr_we, sr_we);
	shiftregister sr(clk, sck, sr_we, dm_out, mosi, sr_contents, miso);
	addresslatch al(clk, sr_contents[6:0], addr_we, dm_addr);
	datamemory dm(clk, dm_out, dm_addr, dm_we, sr_contents);

endmodule
