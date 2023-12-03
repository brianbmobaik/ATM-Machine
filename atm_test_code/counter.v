`timescale 1ns / 1ps

module counter(
    input clk,
    input reset,        // reset value of account to $0
    input increment,    // deposit money
    input decrement,    // withdraw money
    input[7:0]amount,   // Money amount ($1,$5,$10,$20,$50,$100)
    output[7:0]count,   // total in account
    output LED2,        // exceed the max value, 255
    output LED3         // not enough in account to withdraw
    );
    
    reg[7:0] current_count = 0; // Addition if deposit, Subtraction if withdraw
    
// Computing the value after deposit or withdraw
always@(posedge clk)begin
    if(reset)
        current_count <=0;
    else if(increment & (count + amount) > count) // else if increment
        current_count <= count + amount; // increment the amount
    else if(decrement & amount <= count)
        current_count <= count - amount; // decrement count by amount
    else
        current_count <= count; // No input, count remains the same
end
    assign count = current_count; // assign current_count to count
    
///////////////////////////    
reg set2 = 0;

// determine LED2, exceed max amount in account of 255
always@(posedge clk) begin
    if(reset)
        set2 <= 0; // reset count to 0
    else if(increment & (count + amount) > count) // increment
        set2 <= 0;
    else if(decrement & amount <= count)
        set2 <= 0;
    else if(increment & (count + amount) < count) // increment but overflow occurs
        set2 <= 1;
    else
        set2 <= LED2; // If no input, count stays the same
end
    assign LED2 = set2;
 
/////////////////////////// 
 
reg set3 = 0;
     
// determine LED3, not enough money when withdraw occurs
always@(posedge clk)begin
    if(reset)
        set3 <= 0; // reset count to 0
    else if(increment & (count + amount) > count) // increment
        set3 <= 0;
    else if(decrement & amount <= count)
        set3 <= 0;
    else if(decrement & amount > count) // try to decrement but overflow
        set3 <= 1;                      // decrement count by amount
    else 
        set3 <= LED3; // If no input, count remains the same
end
    assign LED3 = set3;    
endmodule
