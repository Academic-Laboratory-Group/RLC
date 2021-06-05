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

reg clock, reset;
reg in_valid = 1, out_ready = 1;
wire in_ready, out_valid, oversize;
integer test_iterator = 0;
reg [0:1][0:31] data_in_tmp = { 32'b1111111_000000000_11111_00000_1_0_1111, 
                                32'b1010_1010_1010_1010_1010_1010_1010_1010 };
reg [0:31] data_in = data_in_tmp[test_iterator];
wire [0:31] data_out;
reg [0:1][0:31] data_out_correct = { 32'b10_101_01_111_10_011_01_011_11_00_10_010_000,
                                     32'b10_101_01_111_10_011_01_011_11_00_10_010_000 };
reg is_correct = 0;

RLC_coder_rtl coder(clock, reset, in_valid, in_ready, out_valid, out_ready, oversize, data_in, data_out);

reg set_reset = 0;

// Clock generator
initial
    clock <= 1'b1;
always
    #5 clock <= ~clock;
 
// Reset signal
always_ff @ (posedge clock)
begin
    if(set_reset == 1'b1)
    begin
        reset <= 1'b1;
        set_reset <= 1'b0;
    end
    else
    if(reset == 1'b1 && set_reset == 1'b0)
        reset <= 1'b0;
end 

// Input logic
always_ff @ (posedge clock) 
begin
    if (reset==1) 
        in_valid<= 0;
    else begin
        in_valid<= 1;
        if (in_valid==1 && in_ready==1)
           data_in <= data_in_tmp[test_iterator];
   end
end

// Output logic
always_ff @ (posedge clock) 
begin
    if (out_valid==1 && out_ready==1)
        out_ready <= 0;
    if(out_valid==1 && out_ready==0) 
    begin
        $stop;
        is_correct <= (data_out == data_out_correct[test_iterator]) ? 1'b1 : 1'b0;
        ++test_iterator;
        set_reset <= 1'b1;
    end
end

endmodule
