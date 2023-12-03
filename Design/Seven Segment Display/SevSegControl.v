`timescale 1ns / 1ps

// Seven Segment Display Control to Control Common Anode LEDs
module SevSegControl (
    input wire rst,                 // Reset
    input wire [31:0] data_in,      // Input Data
    input wire [3:0] LED_Select,    // Digit Select

    output reg [31:0] digit_out,    // Output Digit Val
    output reg [7:0] LED_Control    // Controls 7 Segment Digits
    );

    always @ ( * ) begin
        if ( rst ) begin
            LED_Control <= 8'hFF;
            digit_out <= 0;
            
        end else begin
            case ( LED_Select )
            // Right Half
            3'b000 : begin
                LED_Control <= 8'hFE;
                digit_out[3:0] <= data_in[3:0];
            end
            3'b001 : begin
                LED_Control <= 8'hFD;
                digit_out[7:4] <= data_in[7:4];
            end
            3'b010 : begin
                LED_Control <= 8'hFB;
                digit_out[11:8] <= data_in[11:8];
            end
            3'b011 : begin
                LED_Control <= 8'hF7;
                digit_out[15:12] <= data_in[15:12];
            end

            // Left Half
            3'b100 : begin
                LED_Control <= 8'hEF;
                digit_out[19:16] <= data_in[19:16];
            end
            3'b101 : begin
                LED_Control <= 8'hDF;
                digit_out[23:20] <= data_in[23:20];
            end
            3'b110 : begin
                LED_Control <= 8'hBF;
                digit_out[27:24] <= data_in[27:24];
            end
            3'b111 : begin
                LED_Control <= 8'h7F;
                digit_out[31:28] <= data_in[31:28];
            end
            default : begin
                LED_Control <= 8'hFF;
                digit_out <= 0;
            end
            endcase
        end
    end
endmodule