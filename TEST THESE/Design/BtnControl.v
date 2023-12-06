`timescale 1ns / 1ps

module BtnControl (
    input clk, rst,
    input [4:0] btn_i,
    output reg [31:0] data_o
    );
    
    wire [4:0] btn_db;
    wire [31:0] data;
    
    reg [2:0] sel;
    reg [31:0] data_i;
    
    BtnDebounce btn (.clk(clk), .rst(rst), .btn_i(btn_i), .btn_o(btn_db));
    
    always @ ( posedge |btn_db or posedge rst ) begin
        if ( rst ) begin
            sel <= 0;
            data_i <= 0;
        end else begin 
            if ( btn_db[0] ) begin
                sel <= sel == 7 ? 0 : sel + 1;
            end else if ( btn_db[1] ) begin
                sel <= sel == 0 ? 7 : sel - 1;
            end else if ( btn_db[2] ) begin
                data_i <= (data_i >= 9) ? 9 : data_i + 1;
            end else if ( btn_db[3] ) begin
                data_i <= (data_i <= 0 ) ? 0 : data_i - 1;
            end else begin
                sel <= sel;
                data_i <= data_i;
            end
        end
    end    
    
    assign data = data_i >> (4 * sel);
    
    always @ ( * ) begin
        case ( sel )
            3'b000 : data_o <= {data_i[31: 4], data[3:0]};
            3'b001 : data_o <= {data_i[31: 8], data[3:0], data_i[ 3:0]};
            3'b010 : data_o <= {data_i[31:12], data[3:0], data_i[ 7:0]};
            3'b011 : data_o <= {data_i[31:16], data[3:0], data_i[11:0]};
            3'b100 : data_o <= {data_i[31:20], data[3:0], data_i[15:0]};
            3'b101 : data_o <= {data_i[31:24], data[3:0], data_i[19:0]};
            3'b110 : data_o <= {data_i[31:27], data[3:0], data_i[23:0]};
            3'b111 : data_o <= {data[3:0], data_i[27:0]};
        endcase
    end
endmodule