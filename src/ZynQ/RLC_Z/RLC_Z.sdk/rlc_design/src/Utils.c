/*
 * Utils.c
 *
 *  Created on: 07.06.2021
 *      Author: Norbert
 */

#include "Utils.h"

char8 readChar()
{
	char8 c;
    outbyte ( c = inbyte() ); // Read data and write it on console
    return c; // cast to int and return
}

u32 reverseBits(u32 num)
{
    u32 reverse_num = 0;
    for (int i = 0; i < 32; ++i)
    {
        if((num & (1 << i)))
           reverse_num |= 1 << ((32 - 1) - i);
    }
    return reverse_num;
}

u32 readOneDigit()
{
	char8 c;
    outbyte ( c = inbyte() ); // Read data and write it on console
    while( c != '1' && c != '0' ) // Block different than logic data
    {
    	print("\n\rBad digit, provide last bit correctly ('1' or '0')\n\r");
    	outbyte ( c = inbyte() );
    }
    return (u32)(c - '0'); // cast to int and return
}

u32 readData()
{
	u32 result = 0;
	for(int i = 0; i < 32; ++i)
	{
		result <<= 1;
		result += readOneDigit();
	}
	return result;
}

void print_binary(u32 data, int size)
{
	data = reverseBits(data);
	for(int i = 0; i < size; ++i)
	{
		outbyte((char8)((data & 1) + '0'));
		data >>= 1;
	}
}

void print_u32(u32 data)
{
	print_binary(data, 32);
}
