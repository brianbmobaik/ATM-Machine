`timescale 1ns / 1ps

module Top(
    input clk, rst,
    input [4:0] btn,
//    input [1:0] sel_mode,
    output [6:0] LED_out,
    output [7:0] LED_ctrl
    );
    
    wire [31:0] btn_data;
    wire [2:0] btn_sel;
    wire sclk_1ms, sclk_250ms;
    
    ClkDivider #(.MAX_COUNT(49999)) clk_1ms (.clk(clk), .rst(rst), .sclk(sclk_1ms));
    ClkDivider #(.MAX_COUNT(24999999)) clk_250ms (.clk(clk), .rst(rst), .sclk(sclk_250ms));
    BtnControl BtnCtrl (.clk(sclk_250ms), .rst(rst), .btn_i(btn), .data_o(btn_data), .sel_o(btn_sel));
    SevSegDisplay SSD (.sclk_1ms(sclk_1ms), .rst(rst), .data(btn_data), .LED_Out(LED_out), .LED_Control(LED_ctrl));
    
//    always @ ( posedge rst or posedge clk ) begin
        
//    end
endmodule
