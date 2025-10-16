`timescale 1ns/1ns
module tb_top;
    reg clk;
    reg reset;
    reg [1:0] sensor_N, sensor_E;
    wire green_N, yellow_N, red_N;
    wire green_E, yellow_E, red_E;

    top uut(.clk(clk), .reset(reset), .sensor_N(sensor_N), .sensor_E(sensor_E),
            .green_N(green_N), .yellow_N(yellow_N), .red_N(red_N),
            .green_E(green_E), .yellow_E(yellow_E), .red_E(red_E));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1; sensor_N=0; sensor_E=0;
        #10 reset=0;

        sensor_N = 3; sensor_E = 1;
        #200;

        sensor_N = 1; sensor_E = 3;
        #200;

        $finish;
    end
endmodule
