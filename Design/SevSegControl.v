`timescale 1ns / 1ps

// Seven Segment Display Control to Control Common Anode LEDs
module SevSegControl (
    input clk_1ms,                      // Refresh Rate: 1 kHz (1 ms CC)
    input rst,                          // Reset
    input [3:0] LED_Select,             // LED_Selector (For Testing only)
    input [3:0] LED_BCD,                // BCD
    output reg [6:0] LED_Out,           // Output for 7 Segment Display
    output reg [7:0] LED_Control        // Controls 7 Segment Displays
    );

    SevSegDecoder d0 ( .LED_BCD(LED_BCD), .LED_out(LED_Out) )

    always @ ( * ) begin
        case ( LED_Select )
        3'b000 : LED_Control = 8'hFE;
        3'b001 : LED_Control = 8'hFD;
        3'b010 : LED_Control = 8'hFB;
        3'b011 : LED_Control = 8'hF7;
        3'b100 : LED_Control = 8'hEF;
        3'b101 : LED_Control = 8'hDF;
        3'b110 : LED_Control = 8'hBF;
        3'b111 : LED_Control = 8'h7F;
        default : LED_Control = 8'hFF;
        endcase
    end
endmodule