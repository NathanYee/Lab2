//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

`include "inputconditioner.v"
`include "corelogic.v"
`include "tri_buf.v"

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output [3:0]    leds        // LEDs for debugging
);

    // Condition inputs
    wire mosi_cond, pos_edge, neg_edge, cs_cond, miso_we, sr_out_serial; 
		reg sr_serial_on_neg_edge;
    inputconditioner mosi_c(clk, mosi_pin, mosi_cond, _, _);
    inputconditioner sclk_c(clk, sclk_pin, _, sclk_pos_edge, sclk_neg_edge);
    inputconditioner cs_c(clk, cs_pin, cs_cond, _, _);

		// Logic
		corelogic cl(clk, sclk_pos_edge, cs_cond, mosi_cond, sr_out_serial, miso_we);

    // D flip-flop
    always @(posedge clk) begin
        if (neg_edge) begin
            sr_serial_on_neg_edge = sr_out_serial;
        end
    end

    // Tri state buffer
    tri_buf tsb(sr_serial_on_neg_edge, miso_pin, miso_we);

endmodule
   
