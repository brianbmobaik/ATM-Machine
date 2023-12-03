`timescale 1ns / 1ps

module Top(
    input Up_Button,
    input Down_Button,
    input reset,
    input [5:0] sw,
    input clk, 
    output [3:0] an,
    output [2:0] LED,
    output [6:0] seg
    );
wire clk_out;
wire deposit;
wire withdraw;
wire up_out;
wire down_out;
wire [1:0] en;
wire [7:0] counter_out;
wire [7:0] e_counter_out;
wire [3:0] mux_out;
wire [3:0] ones, tens, hundreds;
wire [7:0] amount;
parameter zeros = 4'b0000;

// putting the system together
Binary_BCD_Converter L1(counter_out, ones, tens, hundreds); //(sw, ones, tens, hundreds);
four_one_Mux L2(zeros, ones, tens, hundreds, e_counter_out,mux_out);
Slow_Clock L3(clk, clk_out);

debounce udb(clk, UP_Button, up_out);
debounce ddb(clk, Down_Button, down_out);

eight_bit_counter L4(clk_out, e_counter_out);
Decoder L5(en,an);
BCD_Seven_Segment L6(mux_out, seg);  

Deposit D(up_out, clk, reset, deposit);
Withdraw WD(down_out, clk, reset,withdraw);
ATM ATM(sw,LED[0],amount);
counter(amount, clk, withdraw, deposit, reset, LED[2:1],counter_out);
    
endmodule