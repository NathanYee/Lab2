module fsm2
(
	input clk,
	input sck, // SCK rising edge
	input cs,      
	input mosi,
	output miso_en,
	output reg dm_we,
	output reg addr_we,
	output reg sr_we
);

	reg [2:0] state;
	reg [2:0] substate;
	reg addr_we_next_cycle;

	localparam J = 1; // Wait
	localparam A = 2; // Address
	localparam Rw = 3; // Read or write?
	localparam R = 4; // Read
	localparam W = 5; // write

	assign miso_en = 1; // We can just leave it enabled

	always @(posedge clk) begin
		if (sck) begin
			case(state)
				J: if (!cs) begin
						state = A;
						substate = 6;
					end else substate = 0;
				A: if (substate == 0) begin
						addr_we_next_cycle = 1; // Save the address
						state = Rw;
					end else substate = substate - 1;
				Rw: if (mosi == 1) begin
						sr_we = 1;
						state = R; substate = 7;
					end else begin
						state = W; substate = 7;
					end
				R: if (substate == 0) begin
						state = J; 
					end else substate = substate - 1;
				W: if (substate == 0) begin
						dm_we = 1;
						state = J;
					end else substate = substate - 1;
			endcase
		end
		else begin // not sck
			if (addr_we_next_cycle == 1) begin
				addr_we = 1;
				addr_we_next_cycle = 0;
			end else 	addr_we = 0;
			sr_we = 0;
		end
	end

endmodule
