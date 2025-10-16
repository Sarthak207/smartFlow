module timer #(parameter WIDTH=16) (
    input  wire clk,
    input  wire reset,
    input  wire start,               
    input  wire [WIDTH-1:0] load_val,  
    output reg  running,             
    output reg  done                  
);
    reg [WIDTH-1:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count   <= 0;
            running <= 1'b0;
            done    <= 1'b0;
        end else begin
            done <= 1'b0; 
            if (start) begin
                count   <= load_val;
                running <= 1'b1;
            end else if (running) begin
                if (count == 0) begin
                    running <= 1'b0;
                    done    <= 1'b1;
                end else begin
                    count <= count - 1;
                end
            end
        end
    end
endmodule
