module lane_fsm #(
    parameter TIMER_WIDTH = 16,
    parameter GREEN_MIN = 50,   
    parameter GREEN_STEP = 25,  
    parameter YELLOW_TIME = 15  
)(
    input  wire clk,
    input  wire reset,
    input  wire grant,              
    input  wire ped_req,               
    input  wire [1:0] density,         
    output reg  green,
    output reg  yellow,
    output reg  red
);

    localparam S_RED    = 2'd0;
    localparam S_GREEN  = 2'd1;
    localparam S_YELLOW = 2'd2;

    reg [1:0] state, next_state;
    reg [TIMER_WIDTH-1:0] timer, next_timer;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_RED;
            timer <= 0;
        end else begin
            state <= next_state;
            timer <= next_timer;
        end
    end

    always @(*) begin
        next_state = state;
        next_timer = timer;

        case (state)
            S_RED: begin
                if (grant) begin
                    next_state = S_GREEN;
                    next_timer = GREEN_MIN + (density * GREEN_STEP);
                    if (ped_req) next_timer = next_timer + GREEN_STEP;
                end
            end

            S_GREEN: begin
                if (timer == 0) begin
                    next_state = S_YELLOW;
                    next_timer = YELLOW_TIME; 
                end else begin
                    next_timer = timer - 1;
                end
            end

            S_YELLOW: begin
                if (timer == 0) begin
                    next_state = S_RED;
                    next_timer = 0;
                end else begin
                    next_timer = timer - 1;
                end
            end

            default: begin
                next_state = S_RED;
                next_timer = 0;
            end
        endcase
    end

    always @(*) begin
        green  = (state == S_GREEN);
        yellow = (state == S_YELLOW);
        red    = (state == S_RED);
    end

endmodule
