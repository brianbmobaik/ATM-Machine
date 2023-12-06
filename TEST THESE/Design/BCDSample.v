`timescale 1ns / 1ps

// Outputs Decimal number from BCD
module BCDSample(
    input [31:0] BCD,
    output [31:0] data
    );
    
    assign data = (BCD[ 3: 0] + 
                  (BCD[ 7: 4] * 10) +
                  (BCD[11: 8] * 100) +
                  (BCD[15:12] * 1000) +
                  (BCD[19:16] * 10000) +
                  (BCD[23:20] * 100000) +
                  (BCD[27:24] * 1000000) +
                  (BCD[31:28] * 10000000));
endmodule
