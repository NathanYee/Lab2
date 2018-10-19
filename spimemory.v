//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

`include "inputconditioner.v"
`include "finitestatemachine.v"
`include "shiftregister.v"
`include "datamemory.v"
`include "addresslatch.v"

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output [3:0]    leds        // LEDs for debugging
)

    // Condition inputs
    wire mosi_cond, pos_edge, neg_edge, cs_cond;
    inputconditioner mosi_c(clk, mosi_pin, mosi_cond, _, _);
    inputconditioner sclk_c(clk, sclk_pin, _, pos_edge, neg_edge);
    inputconditioner cs_c(clk, cs_pin, cs_cond, _, _);

    // Finite State Machine
    wire miso_we, dm_we, sr_we, addr_we;
    finitestatemachine fsm(clk, pos_edge, cs_cond, mosi_cond, miso_we, dm_we, addr_we, sr_we);

    // Shift Register
   	wire [7:0] dm_out, sr_contents;
    shiftregister sr(clk, pos_edge, sr_we, dm_out, mosi_cond, sr_contents);

    // Address Latch
	wire [6:0] dm_addr;
    addresslatch al(clk, sr_contents[6:0], addr_we, dm_addr);

    // Data Memory
    datamemory dm(clk, dm_out, dm_addr, dm_we, sr_contents);

    // DFF + Output
    

endmodule
   
