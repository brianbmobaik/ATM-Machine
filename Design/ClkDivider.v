`timescale 1ns / 1ps

// MAX_COUNT = [( target_CC / input_CC ) / 2 ] - 1
// MAX_COUNT = 32'd399999 -> 10ns CC to 8ms CC (100 MHz to 125 Hz)

module ClkDivider #(parameter MAX_COUNT = 32'd799999) (
    input clk,          // 100 MHz => 100 000 000 Hz (10 ns)
    input rst,          // Reset (Async)
    output reg sclk     // Output Clock Signal
    );

    reg [31:0] count;

    always @(posedge clk or posedge rst) begin
        if(rst == 1'b1) begin
            count <= 32'd0;
            sclk <= 1'b0;
        end else begin
            if(count == MAX_COUNT) begin       // 10ns CC => 8ms CC (125 Hz)
                count <= 32'd0;
                sclk <= ~sclk;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule