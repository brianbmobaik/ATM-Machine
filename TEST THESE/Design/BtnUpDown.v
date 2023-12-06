`timescale 1ns / 1ps

module BtnUpDown(
    input rst,
    input [4:0] btn,
    input [3:0] data_i,
    output reg [3:0] data_o
    );
    
//    wire btnU, btnD;
    
//    assign btnU = btn[2];
//    assign btnD = btn[3];
    
    always @( posedge rst )
    begin
        if ( rst ) begin
            data_o <= 0;
        end
    end
    
    always @( posedge |btn ) 
    begin
        if ( btn[2] ) begin
            data_o <= (data_i >= 9) ? 9 : data_i + 1;
        end else if ( btn[3] ) begin
            data_o <= (data_i <= 0 ) ? 0 : data_i - 1;
        end else if ( btn[0] || btn[1] ) begin
            data_o <= data_i;
        end
    end
    
    always @( * ) begin
        data_o <= data_i;
    end
endmodule
