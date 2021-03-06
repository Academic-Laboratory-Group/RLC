/*
 * rlc_coder.c
 *
 *  Created on: 07.06.2021
 *      Author: Norbert
 */
#include "rlc_coder.h"
#include "Utils.h"

int bin2RLC(u32 data_in, u32* data_out, u32* oversize)
{
	u32 control = 0;

#ifdef _DEBUG
	u32 flags = 0;

	print("\n\rCheck ports:");
	print("\n\rIN:");
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_IN_FLAGS_OFF);
	print_u32(flags);
	print("\n\rOUT:");
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_OUT_FLAGS_OFF);
	print_u32(flags);
	print("\n\r");
	print("\n\r");


	print("\n\rSet controll bits to 0b00");
	control = CLEAR_BIT(control, 1);
	control = CLEAR_BIT(control, 0);
	print("\n\rControl bits: \n\r");
	print_u32(control);
	CODER_IP_mWriteReg(CODER_BASE_ADDR, CODER_IN_FLAGS_OFF, control);
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_IN_FLAGS_OFF);
	print("\n\rAre they on register?:\n\r");
	print_u32(flags);
	print("\n\r");
	print("\n\r");

	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_OUT_FLAGS_OFF);
	print("\n\rCheck out flags: \n\r");
	print_u32(flags);

	print("\n\rWrite data_in: \n\r");
	print_u32(data_in);
#endif
	// Fill data vector
	CODER_IP_mWriteReg(CODER_BASE_ADDR, CODER_DATA_IN_OFF, data_in);
#ifdef _DEBUG
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_DATA_IN_OFF);
	print("\n\rCheck if written: \n\r");
	print_u32(flags);
	print("\n\r");
	print("\n\r");


	print("\n\rSet start: \n\r");
#endif
	// Start FLAG
	control = SET_BIT(control, 0);
#ifdef _DEBUG
	print("\n\rcontrol: \n\r");
	print_u32(control);
#endif
	CODER_IP_mWriteReg(CODER_BASE_ADDR, CODER_IN_FLAGS_OFF, control);
#ifdef _DEBUG
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_IN_FLAGS_OFF);
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
	CODER_IP_mWriteReg(CODER_BASE_ADDR, CODER_IN_FLAGS_OFF, control);
#ifdef _DEBUG
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_IN_FLAGS_OFF);
	print("\n\rAre they on register?:\n\r");
	print_u32(flags);
	print("\n\r");
	print("\n\r");

	// Wait for OUT_VALID in status register
	print("\n\rWait for OUT_VALID");
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_OUT_FLAGS_OFF);
	print("\n\rIOUT_VALID now: \n\r");
	print_u32(flags);
	print("\n\rWhile");
#endif
	while( (CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_OUT_FLAGS_OFF) & 1) != 1);
#ifdef _DEBUG
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_OUT_FLAGS_OFF);
	print("\n\rAfter while out flags: \n\r");
	print_u32(flags);
	print("\n\r");
	print("\n\r");

	print("\n\rRead data out");
#endif
	// Read data
	*data_out = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_DATA_OUT_OFF);
#ifdef _DEBUG
	print("\n\r*data_out: \n\r");
	print_u32(*data_out);
	print("\n\r");
	print("\n\r");
#endif

	// Read oversize
	*oversize = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_OUT_FLAGS_OFF) >> 1;

#ifdef _DEBUG
	print_u32(*oversize);
	print("\n\rAll registers:\n\r");
	print("\n\rreg0: ");
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_IP_S00_AXI_SLV_REG0_OFFSET);
	print_u32(flags);
	print("\n\rreg1: ");
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_IP_S00_AXI_SLV_REG1_OFFSET);
	print_u32(flags);
	print("\n\rreg2: ");
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_IP_S00_AXI_SLV_REG2_OFFSET);
	print_u32(flags);
	print("\n\rreg3: ");
	flags = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_IP_S00_AXI_SLV_REG3_OFFSET);
	print_u32(flags);
	print("\n\r");
	print("\n\r");

#endif

	return 0; // SUCCESS
}
