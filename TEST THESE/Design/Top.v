`timescale 1ns / 1ps

module Top(
    input clk, rst,
    input [4:0] btn,
    input [1:0] sel_mode,
    input [3:0] sel_reg,
    output [6:0] LED_out,
    output [7:0] LED_ctrl
    );
    
    wire [31:0] btn_data, reg_data, deci_btn, bcd_reg, bcd_data;
    wire sclk_1ms, sclk_250ms;
    wire flag;
    reg [31:0] data, calc_data;
    
    parameter S = 2'b00;
    parameter D = 2'b01;
    parameter W = 2'b10;
    
    ClkDivider #(.MAX_COUNT(49999)) clk_1ms (.clk(clk), .rst(rst), .sclk(sclk_1ms));
    ClkDivider #(.MAX_COUNT(24999999)) clk_250ms (.clk(clk), .rst(rst), .sclk(sclk_250ms));
    BtnControl BtnCtrl (.clk(sclk_250ms), .rst(rst), .btn_i(btn), .data_o(btn_data), .flag(flag));
    SevSegDisplay SSD (.sclk_1ms(sclk_1ms), .rst(rst), .data(data), .LED_Out(LED_out), .LED_Control(LED_ctrl));
    RegFile rf (.clk(clk), .rst(rst), .we(^sel_mode & flag), .sel(sel_reg), .data_i(calc_data), .data_o(reg_data));
    
    BCDSample samp (.BCD(btn_data), .data(deci_btn));
    BCDDriver driv1 (.data(reg_data), .BCD(bcd_reg));
    
    always @ ( posedge rst or posedge sclk_1ms ) begin
        if ( rst ) begin
            data <= 0;
            calc_data <= 0;
        end else begin
            case ( sel_mode )
                S : begin
                    data <= bcd_reg;
                end
                D : begin
                    if ( flag ) begin
                        calc_data <= reg_data + deci_btn;
                    end else begin
                        data <= btn_data;
                    end
                end
                W : begin
                    if ( flag ) begin
                        calc_data <= reg_data - deci_btn;
                    end else begin
                        data <= btn_data;
                    end
                end
            endcase
        end    
    end
endmodule
