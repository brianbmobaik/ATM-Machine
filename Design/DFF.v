`timescale 1ns / 1ps

// N-Bit DFF (Default to 1-Bit)
module DFF #(parameter WIDTH = 1)(
    input wire clk, rst,
    input wire en,
    input wire [WIDTH-1:0] dataIn,
    output reg [WIDTH-1:0] dataOut
    );
    
    always @ ( posedge(clk) or posedge(rst) )
        if ( rst ) begin
            dataOut <= 0;
        end else if ( clk ) begin
            if ( en ) begin
                dataOut <= dataIn;
            end
        end
endmodule