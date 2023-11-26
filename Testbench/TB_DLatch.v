`timescale 1ns / 1ps

module TB_test ();
  
  parameter WIDTH = 4;
  reg  en, rst;
  reg  [WIDTH-1:0] dataIn;
  wire [WIDTH-1:0] dataOut;
  
  DLatch #(.WIDTH(WIDTH)) DUT (
    .en(en),
    .rst(rst),
    .dataIn(dataIn),
    .dataOut(dataOut)
  );
  
  initial
    begin
      rst <= 1'b1; en <= 1'b0; 
      dataIn <= 4'b0000; #10;
      
      rst <= 1'b0; en <= 1'b1;
      dataIn <= 4'b0101; #20;
      dataIn <= 4'b1100; #20;
      
      en <= 1'b0;
      dataIn <= 4'b1111; #20;
      dataIn <= 4'b0001; #20;
      
      en <= 1'b1; #10;
    end
endmodule