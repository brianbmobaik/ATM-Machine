`timescale 1ns / 1ps

// 1-Bit D-Latch
module DLatch (
    input wire en, rst,
    input wire dataIn,
    output reg dataOut
    );

    always @( en or rst or dataIn ) begin
        if( rst == 1'b1 ) begin
            dataOut <= 1'b0;
        end else begin
            if( en == 1'b1 ) begin
                dataOut <= dataIn;
            end
        end
    end
endmodule