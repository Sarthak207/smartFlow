module arbiter (
    input  wire [1:0] dens_N,
    input  wire [1:0] dens_E,
    input  wire [1:0] dens_S,
    input  wire [1:0] dens_W,
    input  wire       ped_N,
    input  wire       ped_E,
    input  wire       ped_S,
    input  wire       ped_W,
    input  wire       emergency_N,
    input  wire       emergency_E,
    input  wire       emergency_S,
    input  wire       emergency_W,
    output reg        grant_N,
    output reg        grant_E,
    output reg        grant_S,
    output reg        grant_W
);
    integer score_N, score_E, score_S, score_W;
    always @(*) begin
        grant_N = 0; grant_E = 0; grant_S = 0; grant_W = 0;

        if (emergency_N | emergency_E | emergency_S | emergency_W) begin
            score_N = (emergency_N ? 100 : 0) + dens_N + (ped_N ? 2 : 0);
            score_E = (emergency_E ? 100 : 0) + dens_E + (ped_E ? 2 : 0);
            score_S = (emergency_S ? 100 : 0) + dens_S + (ped_S ? 2 : 0);
            score_W = (emergency_W ? 100 : 0) + dens_W + (ped_W ? 2 : 0);
        end else begin
            score_N = dens_N + (ped_N ? 2 : 0);
            score_E = dens_E + (ped_E ? 2 : 0);
            score_S = dens_S + (ped_S ? 2 : 0);
            score_W = dens_W + (ped_W ? 2 : 0);
        end
        
        if (score_N >= score_E && score_N >= score_S && score_N >= score_W) grant_N = 1;
        else if (score_E >= score_N && score_E >= score_S && score_E >= score_W) grant_E = 1;
        else if (score_S >= score_N && score_S >= score_E && score_S >= score_W) grant_S = 1;
        else grant_W = 1;
    end
endmodule

