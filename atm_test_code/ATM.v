`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module ATM (
    input[5:0]switch,       // 6 different Bills ($1,$5,$10,$20,$50,$100)
    output[7:0] amount,     // total money in the account
    output LED              // shows if more than one dollar is entered
    );
    
    reg [7:0] bill_amount = 8'b00000000; // assigns values
    
    // one switch is up at a time. Else LED warning goes off
    always@(switch)
    begin
        case(switch)
            1:
                bill_amount = 8'b00000001; // $1, if SW[0] is flipped
            2:
                bill_amount = 8'b00000101; // $5, if SW[1] is flipped
            4:
                bill_amount = 8'b00001010; // $10, if SW[2] is flipped
            8:
                bill_amount = 8'b00010100; // $20, if SW[3] is flipped
            16:
                bill_amount = 8'b00110010; // $50, if SW[4] is flipped
            32:
                bill_amount = 8'b01100100; // $100, if SW[5] is flipped
            default:
                bill_amount = 8'b00000000; // $0 as default
       endcase
   end  
   assign amount = bill_amount; 
   
   // one switch is up at a time. Else LED warning goes off
   reg active = 1'b0;
   
   always@(switch)
   begin
        case(switch)
            0: 
                active = 1'b0; // $0
            1:  
                active = 1'b0; // $1
            2: 
                active = 1'b0; // $5
            4:
                active = 1'b0; // $10
            8: 
                active = 1'b0; // $20
            16:
                active = 1'b0; // $50
            32:
                active = 1'b0; // $100
            default:
                active = 1'b1; // default $0 
        endcase
  end
  assign LED = active; 
endmodule