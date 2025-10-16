module lane_fsm(
    input clk,
    input reset,
    input grant,          
    input [1:0] density,  
    output reg green,
    output reg yellow,
    output reg red
);
    localparam IDLE=0, GREEN=1, YELLOW=2, RED=3;
    reg [1:0] state;
    reg [7:0] timer_val;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED;
            green <= 0; yellow <= 0; red <= 1;
            timer_val <= 10;
        end else begin
            case(state)
                RED: if(grant) begin state <= GREEN; timer_val <= 10 + density*5; end
                GREEN: if(timer_val==0) state <= YELLOW; else timer_val <= timer_val -1;
                YELLOW: if(timer_val==0) state <= RED; else timer_val <= timer_val -1;
            endcase

            green  <= (state==GREEN);
            yellow <= (state==YELLOW);
            red    <= (state==RED);
        end
    end
endmodule
