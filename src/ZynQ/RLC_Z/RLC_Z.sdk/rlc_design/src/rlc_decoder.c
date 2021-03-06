/*
 * rlc_decoder.c
 *
 *  Created on: 07.06.2021
 *      Author: Norbert
 */

#include "rlc_decoder.h"

int RLC2bin(u32 data_in, u32* data_out, u32* undersize)
{
	u32 control = 0;

#ifdef _DEBUG
	u32 flags = 0;

	print("\n\rCheck ports:");
	print("\n\rIN:");
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_IN_FLAGS_OFF);
	print_u32(flags);
	print("\n\rOUT:");
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_OUT_FLAGS_OFF);
	print_u32(flags);
	print("\n\r");
	print("\n\r");


	print("\n\rSet controll bits to 0b00");
	control = CLEAR_BIT(control, 1);
	control = CLEAR_BIT(control, 0);
	print("\n\rControl bits: \n\r");
	print_u32(control);
	DECODER_IP_mWriteReg(DECODER_BASE_ADDR, DECODER_IN_FLAGS_OFF, control);
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_IN_FLAGS_OFF);
	print("\n\rAre they on register?:\n\r");
	print_u32(flags);
	print("\n\r");
	print("\n\r");

	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_OUT_FLAGS_OFF);
	print("\n\rCheck out flags: \n\r");
	print_u32(flags);

	print("\n\rWrite data_in: \n\r");
	print_u32(data_in);
#endif
	// Fill data vector
	DECODER_IP_mWriteReg(DECODER_BASE_ADDR, DECODER_DATA_IN_OFF, data_in);
#ifdef _DEBUG
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_DATA_IN_OFF);
	print("\n\rCheck if written: \n\r");
	print_u32(flags);
	print("\n\r");
	print("\n\r");


	// Start FLAG
	print("\n\rSet start: \n\r");
#endif
	control = SET_BIT(control, 0);
#ifdef _DEBUG
	print("\n\rcontrol: \n\r");
	print_u32(control);
#endif
	DECODER_IP_mWriteReg(DECODER_BASE_ADDR, DECODER_IN_FLAGS_OFF, control);
#ifdef _DEBUG
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_IN_FLAGS_OFF);
	print("\n\rAre they on register?:\n\r");
	print_u32(flags);
	print("\n\r");
	print("\n\r");

	print("\n\rClear start: \n\r");
#endif
	// clear Start FLAG
	control = CLEAR_BIT(control, 0);
#ifdef _DEBUG
	print("\n\rcontrol: \n\r");
	print_u32(control);
#endif
	DECODER_IP_mWriteReg(DECODER_BASE_ADDR, DECODER_IN_FLAGS_OFF, control);
#ifdef _DEBUG
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_IN_FLAGS_OFF);
	print("\n\rAre they on register?:\n\r");
	print_u32(flags);
	print("\n\r");
	print("\n\r");

	// Wait for OUT_VALID in status register
	print("\n\rWait for OUT_VALID");
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_OUT_FLAGS_OFF);
	print("\n\rIOUT_VALID now: \n\r");
	print_u32(flags);
	print("\n\rWhile");
#endif
	while( (DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_OUT_FLAGS_OFF) & 1) != 1);
#ifdef _DEBUG
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_OUT_FLAGS_OFF);
	print("\n\rAfter while out flags: \n\r");
	print_u32(flags);
	print("\n\r");
	print("\n\r");

	print("\n\rRead data out");
#endif
	// Read data
	*data_out = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_DATA_OUT_OFF);
#ifdef _DEBUG
	print("\n\r*data_out: \n\r");
	print_u32(*data_out);
	print("\n\r");
	print("\n\r");
#endif

	// Read undersize
	*undersize = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_OUT_FLAGS_OFF) >> 1;

#ifdef _DEBUG
	print_u32(*undersize);
	xil_printf("\n\r%u", undersize);

	print("\n\rAll registers:\n\r");
	print("\n\rreg0: ");
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_IP_S00_AXI_SLV_REG0_OFFSET);
	print_u32(flags);
	print("\n\rreg1: ");
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_IP_S00_AXI_SLV_REG1_OFFSET);
	print_u32(flags);
	print("\n\rreg2: ");
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_IP_S00_AXI_SLV_REG2_OFFSET);
	print_u32(flags);
	print("\n\rreg3: ");
	flags = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_IP_S00_AXI_SLV_REG3_OFFSET);
	print_u32(flags);
	print("\n\r");
	print("\n\r");
#endif

	return 0; // SUCCESS
}
