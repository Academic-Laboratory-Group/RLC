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


module RLC_decoder_rtl(clock, reset, start, out_ready, waste, datain, dataout);
parameter integer unsigned vector_size = 32;
parameter integer unsigned under_size = 5;
parameter integer iteration = 16;
input clock, reset, start;
output reg out_ready;
output reg [0:under_size-1] waste;
input [0:vector_size-1] datain;
output reg [0:vector_size-1] dataout;

//Algorithm Variables
reg [0:vector_size-1] a_datain; // input data
reg [0:vector_size-1] a_dataout; // input data
reg [0:under_size-1] a_waste;

// compression state
reg [0:1]letter;
reg [0:2]letter_amount;
integer unsigned i, j, k ,m ;

parameter S1 = 4'h01, S2 = 4'h02, S3 = 4'h03, S4 = 4'h04, S5 = 4'h05, 
          S6 = 4'h06;
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
                    a_waste <= {under_size{0}};
                    waste <= {under_size{0}};
                    letter = {2{0}};
                    letter_amount = {3{0}}; 
                    i = 0;
                    j = 0;
                    k = 0;
                    m = 0;
                    out_ready <= 1'b0;
                    state <= S3;
                end
            S3: begin
                    a_datain <= datain;
                    state <= S4;
                end
            S4:begin
                    if(i < vector_size && k < vector_size)
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
                    else
                    begin
                        if(i < vector_size )
                        begin
                            a_waste = unsigned'(vector_size - i);
                        end
                        state <= S5;
                    end
                end
            S5:begin
                    dataout <= a_dataout;
                    waste <= a_waste;
                    out_ready <= 1; 
                    state <= S6;
               end
            S6:begin
                    if(start == 1'b0) state <= S1; else state <= S5;
               end
         endcase
     end
end
endmodule
