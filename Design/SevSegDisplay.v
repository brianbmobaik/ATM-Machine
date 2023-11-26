`timescale 1ns / 1ps

// Seven Segment Display
module SevSegDisplay (
    input clk,                          // 100 MHz (10 ns CC)
    input rst,                          // Reset
    input wire [3:0] LED_BCD,           // BCD
    output reg [6:0] LED_Out,           // Output
    output reg [7:0] LED_Control        // Controls 7 Segment Displays
    );

    reg [2:0] LED_Select;               // This is only for testing purpose

    wire sclk_1ms, sclk_8ms;

    ClkDivider #( MAX_COUNT(32'd39999) ) clk_1ms ( .clk(    clk), .rst(rst), .sclk(sclk_1ms) );
    ClkDivider #( MAX_COUNT(    32'd8) ) clk_8ms ( .clk(clk_1ms), .rst(rst), .sclk(sclk_8ms) );

    // A simple LED Counter for testing purpose
    always @ ( posedge sclk_1ms or posedge rst ) begin
        if ( rst || LED_Select == 7 ) begin
            LED_Select <= 0;
        end else begin
            LED_Select <= LED_Select + 1;
        end
    end

    SevSegControl ctrl ( .clk_1ms(clk_1ms), .rst(rst), .LED_Select(LED_Select), 
                         .LED_Out(.LED_Out) .LED_Control(.LED_Control) )

    
endmodule