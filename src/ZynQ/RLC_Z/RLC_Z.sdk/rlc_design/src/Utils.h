/*
 * Utils.h
 *
 *  Created on: 07.06.2021
 *      Author: Norbert
 */

#ifndef SRC_UTILS_H_
#define SRC_UTILS_H_

#define CLEAR_BIT(v,a) (v & ~(((u32)1) << a))
#define SET_BIT(v,a) (v | (((u32)1) << a))

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"

char8 readChar();
u32 reverseBits(u32 num);
u32 readOneDigit();
u32 readData();
void print_binary(u32 data, int size);
void print_u32(u32 data);


#endif /* SRC_UTILS_H_ */
