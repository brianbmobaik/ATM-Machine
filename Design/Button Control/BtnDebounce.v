`timescale 1ns / 1ps

// Button Debounce Module
module BtnDebounce (
    input wire clk,         // 250 ms clk
    input wire rst,         // Reset
    input wire btn_in,      // Input button signal
    output reg btn_out      // Output button signal
    );

    wire Q0, Q1, Q1bar;

    BtnDFF D0 (.clk(clk), .rst(rst), .D(btn_in), .Q(Q0));
    BtnDFF D1 (.clk(clk), .rst(rst), .D(Q0), .Q(Q1));

    assign Q1bar = ~Q1;
    assign btn_out = Q0 & Q1bar;
    
endmodule