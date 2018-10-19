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

    wire mosi_cond, pos_edge, neg_edge, cs_cond;
    inputconditioner mosi_c(clk, mosi_pin, mosi_cond, _, _);
    inputconditioner sclk_c(clk, sclk_pin, _, pos_edge, neg_edge);
    inputconditioner cs_c(clk, cs_pin, cs_cond, _, _);

endmodule
   
