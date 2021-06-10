`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2021 13:01:54
// Design Name: 
// Module Name: RLC_coder_rtl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RLC_coder_rtl(clock, reset, start, out_ready, oversize, datain, dataout);

parameter integer vector_size = 32;
parameter integer letter_info_size = 2; // const parameter
parameter integer letter_amount_size = 3; // const parameter (amount of bits + 2, because 0 and 1 are not possible)
input clock;
input reset;
input start;
output reg oversize;
output reg out_ready;
input [0:vector_size-1] datain;
output reg [0:vector_size-1] dataout;

//Algorithm Variables
reg [0:vector_size-1] a_datain; // input data
reg [0:vector_size-1] a_dataout; // input data
reg a_oversize;

// compression state
integer letter_amount = 0;
integer letter = 0;
reg over_size = 0;
integer j = 0;
integer i = 1;
parameter S1 = 4'h01, S2 = 4'h02, S3 = 4'h03, S4 = 4'h04, S5 = 4'h05, 
          S6 = 4'h06, S7 = 4'h07;
reg [3:0] state;

always @ (posedge clock)
begin
    if(reset==1'b1)
    begin
        out_ready <= 1'b0;
        state <= S1;
    end
    else
    begin
        case(state)
            S1: begin
                    if(start == 1'b1) state <= S2; else state <= S1;
                end
            S2: begin
                    a_datain <= {vector_size{0}};
                    a_dataout <= {vector_size{0}};
                    dataout <= {vector_size{0}};
                    over_size = 0;
                    a_oversize <= 0;
                    oversize <= 0;
                    letter_amount = 1;
                    letter = 0;
                    out_ready <= 1'b0;
                    j = 0;
                    i = 1;
                    state <= S3;
                end
            S3: begin
                    a_datain <= datain;
                    letter <= datain[0];
                    state <= S4;
                end
            S4:begin
                    if(i < vector_size && a_oversize != 1)
                    begin
                        if(letter == a_datain[i] && letter_amount < 9)
                            letter_amount++;
                        else
                        begin 
                            if (letter_amount == 1)
                            begin
                                if (!(j < vector_size - letter_info_size))
                                begin
                                    a_oversize = 1;
                                    state <= S6;
                                end
                                else
                                begin
                                    a_dataout[j +: letter_info_size] = (letter == 1'b1) ? 2'b11 : 2'b00;
                                    j = j + letter_info_size;
                                end
                            end
                            else
                            begin                        
                                if (!(j < vector_size - letter_info_size - letter_amount_size))
                                begin
                                    a_oversize = 1;
                                    state <= S6;
                                end
                                else
                                begin
                                    a_dataout[j +: letter_info_size] = (letter == 1'b1) ? 2'b10 : 2'b01; // 10 is 1, 01 is 0
                                    j = j + letter_info_size;
                                    a_dataout[j +: letter_amount_size] = letter_amount - 2; // TODO: hopes that it will cast automaticly
                                    j = j + letter_amount_size;
                                    letter_amount = 1;
                                end
                            end
                            letter = a_datain[i];
                        end
                        i = i + 1;
                    end
                    else
                    begin
                        state <= S5;
                    end
                end
            S5:begin
                    if (!a_oversize)
                    begin
                        if (letter_amount == 1)
                        begin
                            // <= bacause j after operation can be equal to vector size
                            if (!(j <= vector_size - letter_info_size))
                            begin
                                a_oversize = 1;
                            end
                            else
                            begin
                                a_dataout[j +: letter_info_size] = (letter == 1'b1) ? 2'b11 : 2'b00;
                                j = j + letter_info_size;
                            end
                        end
                        else
                        begin   
                            // <= bacause j after operation can be equal to vector size                     
                            if (!(j <= vector_size - letter_info_size - letter_amount_size))
                            begin
                                a_oversize = 1;
                            end
                            else
                            begin
                                a_dataout[j +: letter_info_size] = (letter == 1'b1) ? 2'b10 : 2'b01; // 10 is 1, 01 is 0
                                j = j + letter_info_size;
                                a_dataout[j +: letter_amount_size] = letter_amount - 2; // TODO: hopes that it will cast automaticly
                                j = j + letter_amount_size;
                                letter_amount = 1;
                            end
                        end
                    end
                    state <= S6;
               end
            S6:begin
                    dataout <= a_dataout;
                    oversize <= a_oversize;
                    out_ready <= 1; 
                    state <= S7;
               end
            S7:begin
                    if(start == 1'b0) state <= S1; else state <= S6;
               end
         endcase
     end
end
endmodule
