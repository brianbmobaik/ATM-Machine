`timescale 1ns / 1ps

//////////////////////////////////////////
//                                      //
//      7-Seg Disp For me to look at    //
//                                      //
//                 a                    //
//             [  ---  ]                //
//           f [ |   | ] b              //
//             [  ---  ]  <-- g         //
//           e [ |   | ] c              //
//             [  ---  ]                //
//                 d                    //
//                                      //
//////////////////////////////////////////

module SevSegDecoder (
    input wire rst,             // Reset
    input wire [3:0] LED_BCD,   // Binary Coded Decimal (Digit's Value)
    output reg [6:0] LED_out    // 7-Segment Display Signal
    );

    // Common Anode
    always @ ( * ) begin
        if ( rst ) begin
            LED_out <= 7'b1111111;
            
        end else begin
            case ( LED_BCD )
                4'h0: LED_out <= 7'b0000001; // 0
                4'h1: LED_out <= 7'b1001111; // 1
                4'h2: LED_out <= 7'b0010010; // 2
                4'h3: LED_out <= 7'b0000110; // 3
                4'h4: LED_out <= 7'b1001100; // 4
                4'h5: LED_out <= 7'b0100100; // 5
                4'h6: LED_out <= 7'b0100000; // 6
                4'h7: LED_out <= 7'b0001111; // 7
                4'h8: LED_out <= 7'b0000000; // 8
                4'h9: LED_out <= 7'b0000100; // 9

                // Extra cases incase we want to use it ( A -> F )
                4'hA: LED_out <= 7'b0001000; // A
                4'hB: LED_out <= 7'b1100000; // b
                4'hC: LED_out <= 7'b0110001; // C
                4'hD: LED_out <= 7'b1000010; // d
                4'hE: LED_out <= 7'b0110000; // E
                4'hF: LED_out <= 7'b0111000; // F

                default: LED_out <= 7'b1111111; // OFF
            endcase;
        end
    end
endmodule