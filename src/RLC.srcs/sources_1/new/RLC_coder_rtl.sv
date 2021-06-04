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


module RLC_coder_rtl(clock, reset, start, datain, dataout);
    
input clock;
input reset;
input start;
input [31:0] datain;
output [31:0] dataout;

always @ (posedge clock)
begin
    if(reset==1'b1)
    begin

    end
    else
    begin
        
    end
end

endmodule
