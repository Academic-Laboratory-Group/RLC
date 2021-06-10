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
parameter integer vector_size = 32;
reg clock, reset, start;
wire out_ready, oversize;

integer test_iterator = 0;
parameter tests_amount = 5;
reg [0:tests_amount-1][0:vector_size-1] data_in_tmp = 
{   32'b11111110000000001111100000101111, // basic data
    32'b1010_1010_1010_1010_1010_1010_1010_1010,// huge oversize
    32'b111111111_111111111_0101_0101_00000_1,  // 1 bit of oversize and 1 bit amount split   
    32'b000000000_000000000_0101010_111111_0,   // 1 bit undersize and 0 bit amount split    
    32'b000000000_0_111111111_1_0000_1111_0101  // exact amount of bits, splitting
};
reg [0:tests_amount-1][0:vector_size-1] data_out_correct = 
{   32'b10101011111001101011110010010000,    // correct encoded data with size margin
    32'b1100_1100_1100_1100_1100_1100_1100_1100,    // huge oversize
    32'b10111_10111_00_11_00_11_00_11_00_11_01011_0,// 1 bit oversize
    32'b01111_01111_00_11_00_11_00_11_00_10100_00_0,// 1 bit undersize
    32'b01111_00_10111_11_01010_10010_00_11_00_11   // exact amount of bits, splitting
};
reg [0:tests_amount-1]oversize_correct = {1'b0, 1'b1, 1'b1, 1'b0, 1'b0};
                                      
reg [0:vector_size-1] data_in = data_in_tmp[test_iterator];
wire [0:vector_size-1] data_out;
reg is_data_correct = 0;
reg is_oversize_correct = 0;

RLC_coder_rtl coder(clock, reset, start, out_ready, oversize, data_in, data_out);

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

initial
begin
    data_in <= data_in_tmp[0];
    start <= 1'b0;
    #20 start <= 1'b1;
    #30 start <= 1'b0;
    data_in <= data_in_tmp[1];
    #400 start <= 1'b1;
    #30 start <= 1'b0;
    data_in <= data_in_tmp[2];
    #200 start <= 1'b1;
    #30 start <= 1'b0;
     data_in <= data_in_tmp[3];
    #400 start <= 1'b1;
    #30 start <= 1'b0;
    data_in <= data_in_tmp[4];
    #400 start <= 1'b1;
    #30 start <= 1'b0;
end
            
// Output logic
always @ (posedge out_ready) 
begin
    is_data_correct <= (data_out == data_out_correct[test_iterator]) ? 1'b1 : 1'b0;
    is_oversize_correct <= (oversize == oversize_correct[test_iterator]) ? 1'b1 : 1'b0;
    test_iterator = test_iterator + 1;

    if(test_iterator == tests_amount + 1)
        $stop;
end
endmodule
