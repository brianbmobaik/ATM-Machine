`timescale 1ns/1ps

module TestModule (
    input clk, rst, en,
    input [4:0] btn,
    input 
    );

    BtnControl btnCtrl (.clk(clk), .rst(rst), .en(en), .btn(btn), .);
    
endmodule