`timescale 1ns / 1ps

// Outputs BCD from deci
module BCDDriver(
    input [31:0] data,
    output [31:0] BCD
    );
    
    assign BCD[ 3: 0] = data % 10;
    assign BCD[ 7: 4] = (data / 10) % 10;
    assign BCD[11: 8] = (data / 100) % 10;
    assign BCD[15:12] = (data / 1000) % 10;
    assign BCD[19:16] = (data / 10000) % 10;
    assign BCD[23:20] = (data / 100000) % 10;
    assign BCD[27:24] = (data / 1000000) % 10;
    assign BCD[31:28] = (data / 10000000) % 10;
endmodule
