`timescale 1ns / 1ps

// Register File
module RegFile (
    input wire clk, rst, en,                         // Clock, Reset, Write Enable bit
    input wire [3:0] sel,                            // Register Select
    input wire [31:0] data_in,
    output reg [31:0] data_out                       // Output Data
    );

    reg [31:0] register [0:15];                      // 16 32-bit Registers
    integer i;

    always @ ( posedge clk or posedge rst ) begin
        if ( rst ) begin
            for(i = 0; i < 16; i = i + 1) begin     // At Reset
                register[i] <= 0;                   // Set all Registers = 0
            end
        end else begin
            if ( en ) begin
                register[sel] <= data_in;           // Write to Register
            end else begin
                data_out <= register[sel];          // Read from Register
            end
        end
    end
endmodule