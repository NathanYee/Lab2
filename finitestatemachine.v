

module finiteStateMachine
(
    input sclk_pin,      // serial clock in
    input cs_pin,        // chip select 
    input mosi_pin,
    output miso_pin,
    output dm_we,
    output addr_we,
    output sr_we
);

    reg [1:0] state;
    reg [2:0] number;

    localparam J = 2'0;
    localparam A = 2'1;
    localparam R = 2'2;
    localparam W = 2'3;

    assign miso_pin = 1;

    always @(posedge sclk_pin) begin
        case(state)
            // J: begin
            // end
            A: begin
                dm_we = 0;
                sr_we = 0;

                case(number)
                    0: begin
                        addr_we = 0; // TODO: check timing
                        if (mosi_pin) state = R;
                        else state = W;
                        number = 7;
                    end
                    1: begin
                        addr_we = 1; // TODO: check timing
                        number = number - 1;
                    end
                    default: begin
                        addr_we = 0;
                        number = number - 1;
                    end

            end
            R: begin
                case (number)
                    7: begin
                        sr_we = 1; // TODO: check timing
                        number = number - 1;
                    end
                    0: begin
                        sr_we = 0; // TODO: check timing
                        state = A; number = 7;
                    default: begin 
                        sr_we = 0; // TODO: check timing
                        number = number - 1;
                    end
            end
            W: begin
                case (number)
                    0: begin
                        dm_we = 1;  // TODO: check timing
                        state = A; number = 7;
                    default: begin 
                        number = number - 1;
                    end
            end

endmodule