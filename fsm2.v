module finiteStateMachine
(
	input clk,
	input sck, // SCK rising edge
	input cs,      
	input mosi,
	output reg miso_en,
	output reg dm_we,
	output reg addr_we,
	output reg sr_we
);

	reg [2:0] state;
	reg [2:0] substate;

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
						addr_we = 1; // Save the address
						state = Rw; substate = 0;
					end
				Rw: if (mosi == 1) begin
						sr_we = 1;
						state = R; substate = 0;
					end else begin
						state = W; substate = 0;
					end
				R: if (substate == 0) begin
						state = J; substate = 0;
					end
				W: if (substate == 0) begin
						dm_we = 1;
						state = J; substate = 0;
					end
			endcase
			substate = substate - 1;
		end
		else begin // not sck
			addr_we = 0;
			sr_we = 0;
		end
	end

endmodule
