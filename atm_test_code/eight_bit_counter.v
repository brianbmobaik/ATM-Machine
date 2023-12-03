`timescale 1ns / 1ps

module eight_bit_counter(
    input clk, // slow clock
    output [7:0] Q ///Potential mistake here took off the REG 
    );
    reg [7:0] temp = 0;
    always@(posedge clk)
    begin
        temp = temp + 1;
    end
    assign Q = temp; // value of the counter gets stored in Q 
endmodule
