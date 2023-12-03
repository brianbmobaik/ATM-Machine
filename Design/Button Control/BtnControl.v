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
    input wire [ 4:0] btn,              // Button Signals
    input wire [31:0] data_in,          // Data to manipulate
    output reg [31:0] data_out          // Data to output
    );

    wire sclk_250ms;                   // 50,000,000 counts

    parameter LEFT   = 5'b00001;       // Select Left LED
    parameter RIGHT  = 5'b00010;       // Select Right LED
    parameter UP     = 5'b00100;       // Increment
    parameter DOWN   = 5'b01000;       // Decrement
    parameter CENTER = 5'b10000;       // Submit

    // Digits
    parameter   D0 = 3'b000,
                D1 = 3'b001,
                D2 = 3'b010,
                D3 = 3'b011,
                D4 = 3'b100,
                D5 = 3'b101,
                D6 = 3'b110,
                D7 = 3'b111;
    
    // Digit reg
    reg [2:0] CurrDigit;

    // Debounce all the buttons
    ClkDivider #(.MAX_COUNT(24999999)) clk_250ms (.clk(clk), .rst(rst), .sclk(sclk_250ms));
    BtnDebounce L (.clk(sclk_250ms), .rst(rst), .btn_in(btn[0]), .btn_out(btn_db[0]));
    BtnDebounce R (.clk(sclk_250ms), .rst(rst), .btn_in(btn[1]), .btn_out(btn_db[1]));
    BtnDebounce U (.clk(sclk_250ms), .rst(rst), .btn_in(btn[2]), .btn_out(btn_db[2]));
    BtnDebounce D (.clk(sclk_250ms), .rst(rst), .btn_in(btn[3]), .btn_out(btn_db[3]));
    BtnDebounce C (.clk(sclk_250ms), .rst(rst), .btn_in(btn[4]), .btn_out(btn_db[4]));

    always @ ( posedge clk or posedge rst ) begin
        if ( rst ) begin
            currDigit <= D0;
        end
    end

    always @ ( * ) begin
        if ( en ) begin
            case ( btn )
                LEFT : begin
                    sel_out <= sel_in == 3'b111 ? 3'b000 : sel_in + 1;
                    data_out <= data_in;
                end
                RIGHT : begin
                    sel_out <= sel_in == 3'b000 ? 3'b111 : sel_in - 1;
                    data_out <= data_in;
                end
                UP : begin
                    sel_out <= sel_in;
                    data_out <= data_in == 4'h9 ? 4'h0 : data_in + 1;
                end
                DOWN : begin 
                    sel_out <= sel_in;
                    data_out <= data_in == 4'h0 ? 4'h9 : data_in + 1;
                end
                CENTER : begin
                    data_out = the_other_one;
                end
                default : begin
                    sel_out <= 0;
                    data_out <= 0;
                end
            endcase
        end
    end
endmodule