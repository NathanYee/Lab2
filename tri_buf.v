// Tri state buffer inspired from:
// http://www.asic-world.com/code/verilog_tutorial/tri_buf.v

module tri_buf (input in, output out, input enable);
    assign out = (enable) ? in : 1'bz;  	  	 
endmodule
