`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2021 18:18:33
// Design Name: 
// Module Name: RLC_decoder_rtl_TB
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


module RLC_decoder_rtl_TB;
parameter integer vector_size = 32;
parameter integer under_size = 5;
reg clock, reset;
reg in_valid = 0, out_ready = 1;
wire in_ready, out_valid;
wire [0:under_size-1] waste;
integer test_iterator = 0;
parameter tests_amount = 5;
reg [0:tests_amount-1][0:31] data_in_tmp = 
{   32'b10101_01111_10011_01011_11_00_10010_000,    // correct encoded data with size margin
    32'b1100_1100_1100_1100_1100_1100_1100_1100,    // huge oversize
    32'b10111_10111_00_11_00_11_00_11_00_11_01011_0,// 1 bit oversize
    32'b01111_01111_00_11_00_11_00_11_00_10100_00_0,// 1 bit undersize
    32'b01111_00_10111_11_01010_10010_00_11_00_11   // exact amount of bits, splitting
};                                   
reg [0:tests_amount-1][0:31] data_out_correct = 
{   32'b1111111_000000000_11111_00000_1_0_1111, // basic data
    32'b1010_1010_1010_1010_0000_0000_0000_0000,// huge oversize
    32'b111111111_111111111_0101_0101_00000_0,  // 1 bit of oversize and 1 bit amount split   
    32'b000000000_000000000_0101010_111111_0,   // 1 bit undersize and 0 bit amount split    
    32'b000000000_0_111111111_1_0000_1111_0101  // exact amount of bits, splitting
};
reg [0:tests_amount-1][0:under_size-1]waste_correct = {5'b00000, 5'b10000, 5'b00001, 5'b00000, 5'b00000};

reg [0:vector_size-1] data_in = data_in_tmp[test_iterator];
wire [0:vector_size-1] data_out;
reg is_correct_waste = 0;

reg is_data_correct = 0;

RLC_decoder_rtl decoder(clock, reset, in_valid, in_ready, out_valid, out_ready, waste, data_in, data_out);

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
        is_data_correct <= 0;
        is_correct_waste <= 0;
    end
    else 
    begin
        if (out_valid==1 && out_ready==1)
        begin
            out_ready <= 0;
            is_data_correct <= (data_out == data_out_correct[test_iterator]) ? 1'b1 : 1'b0;
            is_correct_waste <= (waste == waste_correct[test_iterator]) ? 1'b1 : 1'b0;
            test_iterator = test_iterator + 1;
            set_reset <= 1'b1; // one clock to reset = 1, so output will be reached
        end
        if(test_iterator == tests_amount && set_reset == 1'b1)
            $stop;
    end
end
endmodule
