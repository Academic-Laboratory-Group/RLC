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


module RLC_coder_rtl(clock, reset, in_valid, in_ready, out_valid, out_ready, oversize, datain, dataout);

parameter integer vector_size = 32;
parameter integer letter_info_size = 2; // const parameter
parameter integer letter_amount_size = 3; // const parameter (amount of bits + 2, because 0 and 1 are not possible)
input clock;
input reset;
input in_valid;
output reg in_ready;
output reg out_valid;
output reg oversize;
input out_ready;
input [0:vector_size-1] datain;
output reg [0:vector_size-1] dataout;

// States
reg compression_valid, compression_done;

//Algorithm Variables
reg [0:vector_size-1] a_datain; // input data
reg [0:vector_size-1] a_dataout; // input data
reg a_oversize;

always @ (posedge clock)
begin
    if(reset==1'b1)
    begin
        in_ready <= 1;
        out_valid <= 0;
        dataout <= {vector_size{0}};
        a_datain <= {vector_size{0}};
        a_dataout <= {vector_size{0}};
        oversize <= 0;
        a_oversize <= 0;
        compression_valid = 0;
    end
    else if (in_ready==1 && in_valid==1)
    begin
        a_datain <= datain;
        in_ready <= 0;
        compression_valid <= 1;
        compression_done <= 0;
    end
    else if(compression_done == 1)
    begin
        dataout <= a_dataout;
        oversize <= a_oversize;
        out_valid <= 1;
    end
    else if(out_valid == 1 && out_ready == 1)
    begin
        out_valid <= 0;
        in_ready <= 1;
        a_oversize <= 0;
        a_datain <= {vector_size{0}};
        a_dataout <= {vector_size{0}};
    end
end

// compression state
//reg [letter_info_size-1:0] letter_info;
//reg [letter_amount_size-1:0] letter_amount;
integer letter_amount = 0;
integer letter = 0;
reg over_size = 0;
integer j = 0;
integer i = 1;

always_ff @ (posedge clock)
begin
    if(reset==1) 
    begin
        compression_done = 0;
        letter_amount = 0;
        letter = 0;
    end
    else if (compression_valid == 1) 
    begin
        letter = a_datain[0];
        letter_amount = 1;
               
        for (i = 1, j = 0; i < vector_size && a_oversize != 1; i++)
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
                        break;
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
                        break;
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
        end
        // Last letters addition
        if (!a_oversize)
        begin
            if (letter_amount == 1)
            begin
                if (!(j < vector_size - letter_info_size))
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
                if (!(j < vector_size - letter_info_size - letter_amount_size))
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
        // Flags
        compression_valid = 0;
        compression_done = 1;
    end
end 

endmodule
