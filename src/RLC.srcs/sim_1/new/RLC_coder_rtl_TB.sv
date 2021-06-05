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
reg in_valid = 0, out_ready = 1;
wire in_ready, out_valid, oversize;
integer test_iterator = 0;
reg [0:1][0:31] data_in_tmp = { 32'b1111111_000000000_11111_00000_1_0_1111, 
                                32'b1010_1010_1010_1010_1010_1010_1010_1010 };
reg [0:31] data_in = data_in_tmp[test_iterator];
wire [0:31] data_out;
reg [0:1][0:31] data_out_correct = { 32'b10_101_01_111_10_011_01_011_11_00_10_010_000,
                                     32'b1100_1100_1100_1100_1100_1100_1100_1100 };
reg is_correct = 0;

RLC_coder_rtl coder(clock, reset, in_valid, in_ready, out_valid, out_ready, oversize, data_in, data_out);

reg set_reset = 1;

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
    if(reset == 1'b1 && set_reset == 1'b0)
        reset <= 1'b0;
end 

// Input logic
always_ff @ (posedge clock) 
begin
    if (reset==1) 
    begin
        in_valid<= 0;
        out_ready<=1;
    end
    else 
    begin
        if (in_ready==1 && in_valid==0)
        begin
            in_valid<=1;
            data_in <= data_in_tmp[test_iterator];
        end
        if (in_ready==1 && in_valid==1)
            in_valid<=0;
   end
end

// Output logic
always_ff @ (posedge clock) 
begin
    if (reset==1) 
    begin
        is_correct<= 0;
    end
    else 
    begin
        if (out_valid==1 && out_ready==1)
        begin
            out_ready <= 0;
            is_correct <= (data_out == data_out_correct[test_iterator]) ? 1'b1 : 1'b0;
            test_iterator = test_iterator + 1;
            set_reset <= 1'b1; // one clock to reset = 1, so output will be reached
        end
        if(test_iterator == 2 && set_reset == 1'b1)
            $stop;
    end
end

endmodule
