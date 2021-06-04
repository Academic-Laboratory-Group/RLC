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
wire in_ready, out_valid;
integer test_terator = 0;
reg [0:1][0:31] data_in_tmp = { 32'b1111111_000000000_11111_00000_1_0_1111, 
                                32'b1010_1010_1010_1010_1010_1010_1010_1010 };
reg [0:31] data_in = data_in_tmp[test_terator];
wire [0:31] data_out;
reg [0:1][0:31] data_out_correct = { 32'b10_101_01_111_10_011_01_011_11_00_10_010_000,
                                     32'b10_101_01_111_10_011_01_011_11_00_10_010_000 };
reg is_correct = 0;

RLC_coder_rtl coder(clock, reset, in_valid, in_ready, out_valid, out_ready, data_in, data_out);


// Clock generator
initial
    clock <= 1'b1;
always
    #5 clock <= ~clock;
 
// Reset signal
initial
begin
    reset <= 1'b1;
    #10 reset <= 1'b0;
end 

// Input logic
always_ff @ (posedge clock) 
begin
    if (reset==1) 
        in_valid<= 0;
    else begin
        in_valid<= 1;
        if (in_valid==1 && in_ready==1)
           data_in <= data_in_tmp[test_terator];
   end
end

// Output logic
always_ff @ (posedge clock) 
begin
    if (out_valid==1 && out_ready==1)
        out_ready <= 0;
    if(out_valid==1 && out_ready==0) 
            $stop;
end

endmodule
