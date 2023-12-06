`timescale 1ns / 1ps

module BtnLeftRight (
    input rst,
    input [4:0] btn,
    input [31:0] data_i,
    output reg [2:0] sel_o,
    output reg [3:0] data_o
    );
    
    reg [2:0] sel;
    wire [31:0] temp;
//    wire btnL, btnR;
    
//    assign btnL = btn[0];
//    assign btnR = btn[1];
    
    always @( posedge |btn or posedge rst )
    begin
        if ( rst ) begin
            sel <= 0;
        end else begin
            if ( btn[0] ) begin
                sel <= sel == 7 ? 0 : sel + 1;
            end else if ( btn[1] ) begin
                sel <= sel == 0 ? 7 : sel - 1;
            end else if (btn[2] || btn[3]) begin
                sel <= sel;
            end
        end
    end
    
    assign temp = data_i >> (4 * sel);
    
    always @ ( * ) begin
        data_o <= temp[3:0];
        sel_o <= sel;
    end
endmodule