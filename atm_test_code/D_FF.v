`timescale 1ns / 1ps

module D_FF(
    input clk,
    input D,
    output reg Q,
    output reg Qbar
    );

always@(posedge clk)
    begin
        Q <= D;
        Qbar <= !Q;
    end  
endmodule
