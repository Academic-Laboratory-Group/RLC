`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2021 22:34:56
// Design Name: 
// Module Name: rlc_design_tb
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


module rlc_design_tb();
    reg clk_n, clk_p;
    wire [31:0] data_out;
    reg reset, reset_n;
    
    // Reset stimulus
    initial
    begin
    reset = 1'b1;
    reset_n = 1'b0;
    #10 reset = 1'b0;
    reset_n = 1'b1;
    end
    // Clocks stimulus
    initial
    begin
    clk_n = 1'b0; //set clk to 0
    clk_p = 1'b1;
    end
    always
    begin
    #5 clk_n = ~clk_n; //toggle clk every 5 time units
    clk_p = ~clk_p; //toggle clk every 5 time units
    end
    
    //Instantiate tested module
    rlc_design_wrapper rlc_design_inst ( clk_n, clk_p, data_out, reset, reset_n);
endmodule
