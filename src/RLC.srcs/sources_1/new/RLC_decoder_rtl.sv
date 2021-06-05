`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2021 18:18:04
// Design Name: 
// Module Name: RLC_decoder_rtl
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


module RLC_decoder_rtl(clock, reset, in_valid, in_ready, out_valid, out_ready, waste, datain, dataout);
parameter integer vector_size = 32;
parameter integer under_size = 5;
input clock;
input reset;
input in_valid;
output reg in_ready;
output reg out_valid;
input out_ready;
output reg [0:under_size-1] waste;
input [0:vector_size-1] datain;
output reg [0:vector_size-1] dataout;

// States
reg compression_valid, compression_done;

//Algorithm Variables
reg [0:vector_size-1] a_datain; // input data
reg [0:vector_size-1] a_dataout; // input data
reg [0:under_size-1] a_waste;

always @ (posedge clock)
begin
    if(reset==1'b1)
    begin
        in_ready <= 1;
        out_valid <= 0;
        dataout <= {vector_size{0}};
        a_datain <= {vector_size{0}};
        a_dataout <= {vector_size{0}};
        a_waste <= {under_size{0}};
        waste <= {under_size{0}};
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
        waste <= a_waste;
        out_valid <= 1;
    end
    else if(out_valid == 1 && out_ready == 1)
    begin
        out_valid <= 0;
        in_ready <= 1;
        a_datain <= {vector_size{0}};
        a_dataout <= {vector_size{0}};
        a_waste <= {under_size{0}};
    end
end

// compression state
reg [0:1]letter = {2{0}};
reg [0:2]letter_amount = {3{0}};
integer i = 0;
integer j = 0;
integer k = 0;
integer counter = 0;

always_ff @ (posedge clock)
begin
    if(reset==1) 
    begin
        compression_done = 0;
        letter = {2{0}};
        letter_amount = {3{0}}; 
        i = 0;
        j = 0;
        k = 0;
    end
    else if (compression_valid == 1) 
    begin
        while(i < vector_size && k < vector_size)
        begin
            letter[0] = a_datain[k];
            letter[1] = a_datain[k+1];
            k = k + 2;
            if(letter == 2'b11)
            begin
                a_dataout[i] = 1'b1; 
                i = i + 1;
            end
            else if(letter == 2'b00)
            begin
                a_dataout[i] = 1'b0;
                i = i + 1;
            end
            else if(letter == 2'b01 || letter == 2'b10)
            begin
                letter_amount[0] = a_datain[k];
                letter_amount[1] = a_datain[k+1];
                letter_amount[2] = a_datain[k+2];
                k = k + 3;
                
                for ( j = 0; j < letter_amount + 2; j++)
                begin
                    if(letter == 2'b01)
                        a_dataout[i] = 1'b0;
                    else if(letter == 2'b10)
                        a_dataout[i] = 1'b1;
                    i = i + 1;
                end
            end
        end
        compression_valid = 0;
        compression_done = 1;
        
        if(i < vector_size)
        begin
            a_waste = (vector_size) - i;
        end
    end
end
endmodule
