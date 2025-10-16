// rtl/top.v
module top (
    input  wire clk,
    input  wire reset,
    input  wire [1:0] sensor_N,
    input  wire [1:0] sensor_E,
    input  wire [1:0] sensor_S,
    input  wire [1:0] sensor_W,
    input  wire       ped_N,
    input  wire       ped_E,
    input  wire       ped_S,
    input  wire       ped_W,
    input  wire       emergency_N,
    input  wire       emergency_E,
    input  wire       emergency_S,
    input  wire       emergency_W,
    output wire green_N, yellow_N, red_N,
    output wire green_E, yellow_E, red_E,
    output wire green_S, yellow_S, red_S,
    output wire green_W, yellow_W, red_W
);
    wire grant_N, grant_E, grant_S, grant_W;

    arbiter arb_u (
        .dens_N(sensor_N), .dens_E(sensor_E), .dens_S(sensor_S), .dens_W(sensor_W),
        .ped_N(ped_N), .ped_E(ped_E), .ped_S(ped_S), .ped_W(ped_W),
        .emergency_N(emergency_N), .emergency_E(emergency_E), .emergency_S(emergency_S), .emergency_W(emergency_W),
        .grant_N(grant_N), .grant_E(grant_E), .grant_S(grant_S), .grant_W(grant_W)
    );

    lane_fsm #(.GREEN_MIN(100), .GREEN_STEP(50), .YELLOW_TIME(30)) laneN(
        .clk(clk), .reset(reset), .grant(grant_N), .ped_req(ped_N), .density(sensor_N),
        .green(green_N), .yellow(yellow_N), .red(red_N)
    );

    lane_fsm laneE(
        .clk(clk), .reset(reset), .grant(grant_E), .ped_req(ped_E), .density(sensor_E),
        .green(green_E), .yellow(yellow_E), .red(red_E)
    );

    lane_fsm laneS(
        .clk(clk), .reset(reset), .grant(grant_S), .ped_req(ped_S), .density(sensor_S),
        .green(green_S), .yellow(yellow_S), .red(red_S)
    );

    lane_fsm laneW(
        .clk(clk), .reset(reset), .grant(grant_W), .ped_req(ped_W), .density(sensor_W),
        .green(green_W), .yellow(yellow_W), .red(red_W)
    );

endmodule
