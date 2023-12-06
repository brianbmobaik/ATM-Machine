`timescale 1ns / 1ps

module BtnControl (
    input clk, rst,
    input [4:0] btn_i,
    output reg [31:0] data_o,
    output reg [2:0] sel_o
    );
    
    wire [2:0] sel;
    wire [4:0] btn_db;
    wire [3:0] LRtoUD, data;
    reg [31:0] data_i = 0;
    
    BtnDebounce btn (.clk(clk), .rst(rst), .btn_i(btn_i), .btn_o(btn_db));
    BtnLeftRight btnLR (.rst(rst), .btn(btn_db), .data_i(data_i),
                        .sel_o(sel), .data_o(LRtoUD));
    BtnUpDown btnUD (.rst(rst), .btn(btn_db), .data_i(LRtoUD), .data_o(data));
    
    always @ ( posedge clk ) begin
        case ( sel )
            3'b000 : data_i[ 3: 0] <= data;
            3'b001 : data_i[ 7: 4] <= data;
            3'b010 : data_i[11: 8] <= data;
            3'b011 : data_i[15:12] <= data;
            3'b100 : data_i[19:16] <= data;
            3'b101 : data_i[23:20] <= data;
            3'b110 : data_i[27:24] <= data;
            3'b111 : data_i[31:28] <= data;
        endcase
    end
    
    always @ ( data_i or sel ) begin
        data_o <= data_i;
        sel_o <= sel;
    end
endmodule