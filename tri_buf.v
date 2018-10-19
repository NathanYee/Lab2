// Tri state buffer taken from:
// http://www.asic-world.com/code/verilog_tutorial/tri_buf.v

module tri_buf (a,b,enable);
 input a;
 output b;
 input enable;
 wire b;
 
assign b = (enable) ? a : 1'bz;
  	  	 
endmodule