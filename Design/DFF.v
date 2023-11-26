`timescale 1ns / 1ps

// N-Bit DFF (Default to 1-Bit)
module DFF #(parameter WIDTH = 1)(
    input wire clk, reset,
    input wire en,
    input wire [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
    );
    
    always @(posedge clk, posedge reset)
        if (reset)
            q <= 1'b0;
        else if (en)
            q <= d;
endmodule