`timescale 1ns / 1ps

module BtnControl (
    input clk, rst,
    input [4:0] btn_i,
    output [31:0] data_o,
    // output flag
    );
    
    wire [4:0] btn_db;
    
    reg [2:0] sel;
    reg [3:0] data [0:7];
    integer i;
    
    BtnDebounce btn (.clk(clk), .rst(rst), .btn_i(btn_i), .btn_o(btn_db));
    
    always @ ( posedge |btn_db or posedge rst ) begin
        if ( rst ) begin
            sel <= 0;
            for(i = 0; i < 8; i = i + 1) begin
                data[i] <= 0;
            end
        end else begin
            if ( btn_db[0] ) begin
                sel <= sel == 7 ? 0 : sel + 1;
            end else if ( btn_db[1] ) begin
                sel <= sel == 0 ? 7 : sel - 1;
            end else if ( btn_db[2] ) begin
                data[sel] <= (data[sel] >= 9) ? 9 : data[sel] + 1;
            end else if ( btn_db[3] ) begin
                data[sel] <= (data[sel] <= 0 ) ? 0 : data[sel] - 1;
            end else begin
                sel <= sel;
                data[sel] <= data[sel];
            end
        end
    end    
    
    // assign flag = btn_db[4];
    assign data_o = {data[7], data[6], data[5], data[4],
                     data[3], data[2], data[1], data[0]};
endmodule