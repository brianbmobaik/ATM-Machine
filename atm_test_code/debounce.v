`timescale 1ns / 1ps

module debounce(
    input pb,
    input clk_in,
    output led
    );
wire clk_out;
wire Q1, Q2, Q2_bar;

Slow_Clock u1(clk_in, clk_out);
D_FF d1(clk_out, pb, Q1);    
D_FF d2(clk_out, Q1, Q2);    
endmodule
