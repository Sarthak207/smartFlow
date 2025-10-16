// tb/tb_top.v
`timescale 1ns/1ns
module tb_top;
    reg clk;
    reg reset;

    // sensors (0..3)
    reg [1:0] sN, sE, sS, sW;
    reg pedN, pedE, pedS, pedW;
    reg emN, emE, emS, emW;

    wire gN, yN, rN, gE, yE, rE, gS, yS, rS, gW, yW, rW;

    top uut (
        .clk(clk), .reset(reset),
        .sensor_N(sN), .sensor_E(sE), .sensor_S(sS), .sensor_W(sW),
        .ped_N(pedN), .ped_E(pedE), .ped_S(pedS), .ped_W(pedW),
        .emergency_N(emN), .emergency_E(emE), .emergency_S(emS), .emergency_W(emW),
        .green_N(gN), .yellow_N(yN), .red_N(rN),
        .green_E(gE), .yellow_E(yE), .red_E(rE),
        .green_S(gS), .yellow_S(yS), .red_S(rS),
        .green_W(gW), .yellow_W(yW), .red_W(rW)
    );

    // clock: period 10 ns
    initial clk = 0;
    always #5 clk = ~clk;

    // waveform
    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);
    end

    initial begin
        // init
        reset = 1;
        sN = 0; sE = 0; sS = 0; sW = 0;
        pedN = 0; pedE = 0; pedS = 0; pedW = 0;
        emN = 0; emE = 0; emS = 0; emW = 0;
        #20;
        reset = 0;

        // Scenario A: low traffic everywhere (rotating by arbiter tie-break)
        sN=0; sE=0; sS=0; sW=0;
        #500;

        // Scenario B: heavy N and S traffic
        sN=3; sE=1; sS=3; sW=0;
        #1000;

        // Scenario C: pedestrian request at East
        pedE = 1;
        #300;
        pedE = 0;
        #700;

        // Scenario D: sudden surge West
        sW = 3; sN = 1; sE = 0; sS = 0;
        #1000;

        // Scenario E: emergency at South
        emS = 1;
        #400;
        emS = 0;
        #400;

        $finish;
    end
endmodule
