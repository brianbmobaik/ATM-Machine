`timescale 1ns / 1ps

module BtnDFF(
    input clk, rst,
    input [4:0] btn_in,
    output reg [4:0] btn_out
    );
    
    always @ (posedge clk or posedge rst) begin
        if ( rst ) begin
            btn_out <= 0;
        end else begin
            btn_out <= btn_in;
        end
    end
endmodule