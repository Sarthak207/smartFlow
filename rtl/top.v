module top(
    input clk,
    input reset,
    input [1:0] sensor_N,
    input [1:0] sensor_E,
    output green_N, yellow_N, red_N,
    output green_E, yellow_E, red_E
);
    wire grant_N, grant_E;

    arbiter arb(.density_N(sensor_N), .density_E(sensor_E), .grant_N(grant_N), .grant_E(grant_E));
    lane_fsm laneN(.clk(clk), .reset(reset), .grant(grant_N), .density(sensor_N), .green(green_N), .yellow(yellow_N), .red(red_N));
    lane_fsm laneE(.clk(clk), .reset(reset), .grant(grant_E), .density(sensor_E), .green(green_E), .yellow(yellow_E), .red(red_E));
endmodule
