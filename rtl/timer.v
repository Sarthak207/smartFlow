module timer #(parameter WIDTH =8)(
    input clk,
    input reset,
    input start,
    input [WIDTH-1:0] load_val,
    output reg done
);
    reg [WIDTH-1:0] count;
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count<=0;
            done<=0;
        end
        else if (start) begin
            count<= load_val;
            done<=0;
        end
        else if(count!=0) begin
            count <= count-1;
            done<=0;
        end
        else begin
            done<=1;
        end
    end
endmodule