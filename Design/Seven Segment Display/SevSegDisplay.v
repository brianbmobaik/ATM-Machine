`timescale 1ns / 1ps

// write_schematic -format pdf -orientation portrait "D:/PhotonUser/My Files/OneDrive/Files/EGEC 446/Schematic/SevSegDisplay.pdf"

// Seven Segment Display
module SevSegDisplay (
    input wire clk, rst,                // CC = 10ns (100 MHz)
    input wire [31:0] data_in,          // Input Data
    output reg [ 6:0] LED_Out,          // 7 Segment LED Pattern
    output reg [ 7:0] LED_Control       // 7 Segment LED Digits
    );

    reg  [2:0] LED_Select;              // Selects Specific Digit of the Display
    wire [3:0] digit_val;               // BCD to be outputted on the digit

    wire sclk_1ms;                      // Digit Refresh Period = 1ms (1 kHz)

    ClkDivider #(.MAX_COUNT(49999)) clk_1ms (.clk(clk), .rst(rst), .sclk(sclk_1ms));

    // Every 1ms, Refreshes a Single Digit ( 1 CC = 8ms (125 Hz))
    always @ ( posedge sclk_1ms or posedge rst ) begin
        if ( rst || LED_Select == 7 ) begin
            LED_Select <= 0;
        end else begin
            LED_Select <= LED_Select + 1;
        end
    end

    // Controls the Individual LED Screens
    SevSegControl C0 ( .rst(rst), .data_in(data_in), .LED_Select(LED_Select), 
                       .digit_out(digit_val), .LED_Control(LED_Control) );
    
    // Outputs the signal for the LED
    SevSegDecoder D0 ( .rst(rst), .LED_BCD(digit_val), .LED_out(LED_Out) );
endmodule