`timescale 1ns / 1ps

module RegFile(
    input clk, rst, we,
    input [3:0] sel,
    input [31:0] data_i,
    output [31:0] data_o
    );
    
    reg [31:0] register [0:15];
    integer i;
    
    always @ ( posedge clk or posedge rst ) begin
        if ( rst ) begin
            for(i = 0; i < 16; i = i + 1) begin
                register[i] <= 0;
            end
        end else begin
            if ( we ) begin
                register[sel] <= data_i;
            end
        end
    end

    assign data_o = register[sel];
endmodule
