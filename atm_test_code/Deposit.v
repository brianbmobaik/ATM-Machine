`timescale 1ns / 1ps

module Deposit(
    input clk,
    input reset,
    input UP_Button, // Deposit money
    output count_up  // Tirggers increment signal
    );
    
localparam S00 = 0, 
FLAG = 1;

reg [1:0] current_state = 0;    // Current State
reg [1:0] next_state = 0;       // Next State
reg set_flag = 1;               // Flag for when to count

// Next State sequential Logic
always@(posedge clk) begin
    if(reset)current_state <= S00;
    else current_state <= next_state;
end

// Next State Combinational Logic
always@(current_state, UP_Button)
begin
    case(current_state)
        S00: begin
            if(UP_Button)
                next_state = FLAG;
            else
                next_state = S00;
         end
         FLAG: begin
            next_state = S00;
         end
         default: begin // implied-latch free implementation
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

// Output assignment
assign count_up = set_flag;
endmodule