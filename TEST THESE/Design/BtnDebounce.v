`timescale 1ns / 1ps

module BtnDebounce(
    input clk, rst,
    input [4:0] btn_i,
    output [4:0] btn_o
    );
    
    wire [4:0] btn0, btn1;
    
    BtnDFF btn_db0 (.clk(clk), .rst(rst), .btn_in(btn_i), .btn_out(btn0));
    BtnDFF btn_db1 (.clk(clk), .rst(rst), .btn_in( btn0), .btn_out(btn1));
    
    assign btn_o = ~btn1 & btn0;
endmodule