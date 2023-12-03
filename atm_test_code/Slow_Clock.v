`timescale 1ns / 1ps

module Slow_Clock(
    input clk_in,   // input clock which is 100 MHz 
    output clk_out  // slow clock at 100 Hz Frequency
    );
    
    reg [25:0] count = 0; // 2 power 20, 1048576
    reg clk_out;
    
always@(posedge clk_in)
begin
    count <= count + 1;
    if(count == 12_500_000)
        begin
            count <= 0;
            clk_out = ~clk_out; // clock signal should invert
        end
end
endmodule
