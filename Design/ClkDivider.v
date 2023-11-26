`timescale 1ns / 1ps

module ClkDivider(
    input clk,          // 100 MHz => 100 000 000 Hz
    input reset,        // Reset (Async)
    output reg sclk     // Output Clock Signal
    );

    reg [31:0] count;

    always @(posedge clk or posedge reset) begin
        if(reset == 1'b1) begin
            count <= 32'd0;
            sclk <= 1'b0;
        end else begin
            if(count == 32'd255) begin
                count <= 32'd0;
                sclk <= ~sclk;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule