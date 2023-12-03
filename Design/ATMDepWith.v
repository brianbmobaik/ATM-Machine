`timescale 1ns / 1ps

module ATMDepWith (
    input wire clk, rst,
    input wire [ 1:0] action,        // [deposit, withdraw]
    input wire [26:0] curr_bal,
    input 
    output reg [26:0] new_bal
    );

    always
endmodule