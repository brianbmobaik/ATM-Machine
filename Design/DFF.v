`timescale 1ns / 1ps

// 1-Bit DFF
module DFF(
    input wire clk, reset,
    input wire en,
    input wire d,
    output reg q
    );
    
    always @(posedge clk, posedge reset)
        if (reset)
            q <= 1'b0;
        else if (en)
            q <= d;
endmodule