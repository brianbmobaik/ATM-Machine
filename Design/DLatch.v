`timescale 1ns / 1ps

// N-Bit D-Latch
module DLatch #(parameter WIDTH = 1) (
    input wire en, rst,
    input wire [WIDTH-1:0] dataIn,
    output reg [WIDTH-1:0] dataOut
    );

    always @( en or rst or dataIn ) begin
        if ( rst ) begin
            dataOut <= 0;
        end else begin
            if ( en ) begin
                dataOut <= dataIn;
            end
        end
    end
endmodule