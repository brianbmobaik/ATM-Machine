`timescale 1ns / 1ps

module Withdraw(
    input clk,
    input reset,
    input Down_Button,      // Withdraw money
    output count_down);     // Triggers decrement signal
    
localparam S00 = 0,     // localparam S00 = 0, S01 = 1, S10 = 2
FLAG = 1;
reg[1:0] current_state = 0;   // Current state
reg[1:0] next_state = 0;      // Next State
reg set_flag = 1;             // Flag for when to count               

// Next State Sequential logic
always@(posedge clk)begin
    if(reset) current_state <= S00;
    else current_state <= next_state;
end

// Next state combinational logic
always@(current_state, Down_Button)
begin
    case(current_state)
        S00: begin
            if(Down_Button)
                next_state = FLAG;
            else
                next_state = S00;
         end
         FLAG: begin
             next_state = S00;
         end
         default: begin  // Inplied-latch free implementation
             next_state = S00;
         end
endcase
end 
                
// Combinational output logic for each state

always@(current_state)begin
    case(current_state)
        S00: begin
        set_flag = 0;
    end
        FLAG: begin
        set_flag = 1;
    end
    default: begin
        set_flag = 0;
    end
endcase
end
// Output Assignment
assign count_down = set_flag;
endmodule
