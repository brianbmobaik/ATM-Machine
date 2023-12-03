`timescale 1ns / 1ps

module BCD_Seven_Segment(
    input [3:0] Y,
    output reg [6:0] disp
    );
    
    always@(Y) // describing an event that should occur 
    begin
    case(Y)
        0: disp = 7'b0000001; // 7-bits are a,b,c,d,e,f,g, segment display
        1: disp = 7'b1001111; // 1
        2: disp = 7'b0010010; // 2     
        3: disp = 7'b0000110; // 3
        4: disp = 7'b1001100; // 4  
        5: disp = 7'b0100100; // 5
        6: disp = 7'b0100000; // 6  
        7: disp = 7'b0001111; // 7
        8: disp = 7'b0000000; // 8
        9: disp = 7'b0001100; // 9
    endcase
end
endmodule
