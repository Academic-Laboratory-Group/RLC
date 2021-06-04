`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2021 13:02:20
// Design Name: 
// Module Name: RLC_coder_rtl_TB
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


module RLC_coder_rtl_TB;
reg clock, reset, start;
reg [31:0] data_in;
reg [31:0] data_out;

RLC_coder_rtl coder(clock, reset, start, data_in, data_out);

//Clock generator
initial
    clock <= 1'b1;
always
    #5 clock <= ~clock;
 
 //Reset signal
initial
begin
    reset <= 1'b1;
    #10 reset <= 1'b0;
end 

initial
begin
    start <= 1'b0;
    #20 start <= 1'b1;
end
endmodule
