/*
 * main.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include "rlc_coder.h"
#include "rlc_decoder.h"
#include "Utils.h"

// #define _DEBUG

int main()
{
	char8 select = 0;
	u32 data_in = 0u, data_out = 0u;

    init_platform();

    while(1)
    {
    	print("\n\rChoose coder or decoder (write 1 to code data, 2 to decode): ");
    	select = readChar(); // get selected task

    	if(select == '1') // coder
    	{
    		// Variables
    		u32 oversize = 0u;

    		// GUI
        	print("\n\rEnter data to code:");
        	data_in = readData();
#ifdef _DEBUG
        	print("\n\rData to code:\n\r");
        	print_u32(data_in);
#endif
        	print("\n\n\rEncoding...");

        	// Encoding
        	if(bin2RLC(data_in, &data_out, &oversize))
        		print("\n\n\rError with encoding!");

        	// Output
        	if(oversize)
        	{
        		print("\n\n\rEncoded data does not fit in 32 bits!");
        		print("\n\rEncoded 32 bits of data:\n\r");
        	}
        	else
        		print("\n\n\rEncoded data:\n\r");

        	print_u32(data_out);
        	print("\n\n\n\r");
    	}
    	else if(select == '2') // decoder
    	{
    		// Variables
    		u32 undersize = 0u;

    		// GUI
        	print("\n\rEnter data to decode:");
        	data_in = readData();
#ifdef _DEBUG
        	print("\n\rData to decode:\n\r");
        	print_u32(data_in);
#endif
        	print("\n\n\rDecoding...");

        	// Decoding
        	if(RLC2bin(data_in, &data_out, &undersize))
        		print("\n\n\rError with decoding!");

        	// Output
        	print("\n\n\rDecoded data:\n\r");
        	print_binary(data_out, 32 - (int)undersize);
        	print("\n\n\n\r");
    	}
    }
}
