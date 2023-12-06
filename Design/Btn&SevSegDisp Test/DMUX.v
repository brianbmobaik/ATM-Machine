`timescale 1ns / 1ps

// Demultiplexer
module DMUX (
    input wire [2:0] sel,            // Selects which digit to output
    input wire [31:0] data_in,       // Every digit is 4-bits wide
    output reg [3:0] data_out       // Output a digit value
    );

    // Output DMUX values
    always @ ( * ) begin
        case( sel )
            3'b000 : data_out <= data_in[ 3: 0];       // Ones
            3'b001 : data_out <= data_in[ 7: 4];       // Tens
            3'b010 : data_out <= data_in[11: 8];       // Hundreds
            3'b011 : data_out <= data_in[15:12];       // Thousands
            3'b100 : data_out <= data_in[19:16];       // 10k
            3'b101 : data_out <= data_in[23:20];       // 100k
            3'b110 : data_out <= data_in[27:24];       // 1M
            3'b111 : data_out <= data_in[31:28];       // 10M
            default : data_out <= 4'b0000;
        endcase
    end
endmodule