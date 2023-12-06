`timescale 1ns / 1ps

//  ||             btn[2]            ||
//  ||                               ||
//  ||    btn[0]   btn[4]  btn[1]    ||
//  ||                               ||
//  ||             btn[3]            ||
//
//  buttons = [Left, Right, Up, Down, Center]

module BtnControl (
    input wire clk, rst, en,           // Reset and Enable
    input wire [4:0] btn,              // Button Signals
    // input wire [3:0] data_in,          // Data to manipulate
    output reg [3:0] data_out          // Data to output
    );

    wire sclk_250ms;                   // 50,000,000 counts
    wire [2:0] sel = 0;
    reg [3:0] data;

    parameter LEFT   = 5'b00001;       // Select Left LED
    parameter RIGHT  = 5'b00010;       // Select Right LED
    parameter UP     = 5'b00100;       // Increment
    parameter DOWN   = 5'b01000;       // Decrement
    parameter CENTER = 5'b10000;       // Submit

    // Debounce all the buttons
    ClkDivider #(.MAX_COUNT(24999 999)) clk_250ms (.clk(clk), .rst(rst), .sclk(sclk_250ms));
    BtnDebounce L (.clk(sclk_250ms), .rst(rst), .btn_in(btn[0]), .btn_out(btn_db[0]));
    BtnDebounce R (.clk(sclk_250ms), .rst(rst), .btn_in(btn[1]), .btn_out(btn_db[1]));
    BtnDebounce U (.clk(sclk_250ms), .rst(rst), .btn_in(btn[2]), .btn_out(btn_db[2]));
    BtnDebounce D (.clk(sclk_250ms), .rst(rst), .btn_in(btn[3]), .btn_out(btn_db[3]));
    BtnDebounce C (.clk(sclk_250ms), .rst(rst), .btn_in(btn[4]), .btn_out(btn_db[4]));

    DMUX dmux (.sel(sel), .);
    
    always @ ( posedge btn_db ) begin
        if ( en ) begin
            case ( btn_db )
                LEFT : begin
                    sel <= sel == 3'b111 ? 3'b000 : sel + 1;
                end
                RIGHT : begin
                    sel <= sel == 3'b000 ? 3'b111 : sel - 1;
                end
                UP : begin
                    current_digit[sel] <= current_digit[sel] == 4'h9 ? 4'h0 : current_digit[sel] + 1;
                end
                DOWN : begin
                    current_digit[sel] <= current_digit[sel] == 4'h0 ? 4'h9 : current_digit[sel] + 1;
                end
                CENTER : begin
                    data_out <= {current_digit[7], current_digit[6], current_digit[5], current_digit[4],
                                 current_digit[3], current_digit[2], current_digit[1], current_digit[0]};
                end
                default : begin
                    data_out <= 0;
                end
            endcase
        end
    end
endmodule