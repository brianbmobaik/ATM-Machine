`timescale 1ns / 1ps

module TB_SevSegDisplay( );
    reg clk, rst;
    reg [31:0] data_in;
    wire [6:0] LED_Out;
    wire [7:0] LED_Control;
    
    SevSegDisplay DUT (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .LED_Out(LED_Out),
        .LED_Control(LED_Control)
        );
    
    initial
        clk = 0;
        always #5 clk = ~clk;
    
    initial 
    begin
        rst <= 1'b1; #10;
        rst <= 1'b0; 
        data_in <= 32'h12345678;
    end
endmodule