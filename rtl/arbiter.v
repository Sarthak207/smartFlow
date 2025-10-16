module arbiter(
    input [1:0] density_N,
    input [1:0] density_E,
    output reg grant_N,
    output reg grant_E
);
    always @(*) begin
        if(density_N >= density_E) begin
            grant_N = 1;
            grant_E = 0;
        end
        else begin
            grant_N = 0;
            grant_E = 1;
        end
    end
endmodule