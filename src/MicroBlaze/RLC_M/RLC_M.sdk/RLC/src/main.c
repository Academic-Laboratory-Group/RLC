/*
 * main.c
 *
 *  Created on: 06.06.2021
 *      Author: Norbert
 */

#include "xparameters.h"
#include "xgpio.h"
#include "coder_ip.h"
#include "decoder_ip.h"
/**************************** user definitions ********************************/
#define CHANNEL 1
//RLC processor base addresses redefinition

// CODER
#define CODER_BASE_ADDR XPAR_CODER_IP_0_S00_AXI_BASEADDR

#define CODER_IN_FLAGS_OFF 	CODER_IP_S00_AXI_SLV_REG0_OFFSET // control
#define CODER_DATA_IN_OFF 	CODER_IP_S00_AXI_SLV_REG1_OFFSET // dataIn
#define CODER_OUT_FLAGS_OFF CODER_IP_S00_AXI_SLV_REG2_OFFSET // status
#define CODER_DATA_OUT_OFF	CODER_IP_S00_AXI_SLV_REG3_OFFSET // dataOut

// DECODER
#define DECODER_BASE_ADDR XPAR_DECODER_IP_0_S00_AXI_BASEADDR

#define DECODER_IN_FLAGS_OFF 	DECODER_IP_S00_AXI_SLV_REG0_OFFSET // control
#define DECODER_DATA_IN_OFF 	DECODER_IP_S00_AXI_SLV_REG1_OFFSET // dataIn
#define DECODER_OUT_FLAGS_OFF 	DECODER_IP_S00_AXI_SLV_REG2_OFFSET // status
#define DECODER_DATA_OUT_OFF	DECODER_IP_S00_AXI_SLV_REG3_OFFSET // dataOut

// OTHERS
#define CLEAR_BIT(v,a) (v & ~(((u32)1) << a))
#define SET_BIT(v,a) (v | (((u32)1) << a))

/***************************** Main function *********************************/

XGpio dataOutGpio;

void failure()
{
	while(1);
}

void initializeGPIO()
{
	// data out
	int status = XGpio_Initialize(&dataOutGpio, XPAR_AXI_GPIO_DATA_OUT_DEVICE_ID);
	if (status != XST_SUCCESS) {
		failure();
	}
	XGpio_SetDataDirection(&dataOutGpio, CHANNEL, 0x000);
}

u32 getSelect(int iterator)
{
	switch (iterator)
	{
		case 0:
			return (u32)0b10;
		case 1:
			return (u32)0b01;
		default:
			return (u32)0;
	}
}

u32 getData(int iterator)
{
	switch (iterator)
	{
	case 0:
		return (u32)0b11111110000000001111100000101111;
	case 1:
		return (u32)0b10101011111001101011110010010000;
	default:
		return (u32)0;
	}
}

int main()
{
	initializeGPIO();

	u32 control = (u32)0;
	u32 data_in = getData(0);
	u32 dataOut = (u32)0;

	u32 select = getSelect(0);

	// CODER
	if(select == (u32)0b10) // coding 2'b10
	{
		// Fill data vector
		CODER_IP_mWriteReg(CODER_BASE_ADDR, CODER_DATA_IN_OFF, data_in);

		// START FLAG
		control = SET_BIT(control, 0);
		CODER_IP_mWriteReg(CODER_BASE_ADDR, CODER_IN_FLAGS_OFF, control);

		// Wait for OUT_READY in status register
		while( (CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_OUT_FLAGS_OFF) & 0x01) != 1);

		// Read data
		dataOut = CODER_IP_mReadReg(CODER_BASE_ADDR, CODER_DATA_OUT_OFF);

		// Write data to output
		XGpio_DiscreteWrite(&dataOutGpio, CHANNEL, dataOut);
	}

	// DECODER
	select = getSelect(1);
	control = (u32)0;
	data_in = getData(1);
	dataOut = (u32)0;
	if(select == (u32)0b01) // decoding 2'b01
	{
		// Fill data vector
		DECODER_IP_mWriteReg(DECODER_BASE_ADDR, DECODER_DATA_IN_OFF, data_in);

		// START FLAG
		control = SET_BIT(control, 0);
		DECODER_IP_mWriteReg(DECODER_BASE_ADDR, DECODER_IN_FLAGS_OFF, control);

		// Wait for OUT_READY in status register
		while( (DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_OUT_FLAGS_OFF) & 0x01) != 1);

		// Read data
		dataOut = DECODER_IP_mReadReg(DECODER_BASE_ADDR, DECODER_DATA_OUT_OFF);

		// Write data to output
		XGpio_DiscreteWrite(&dataOutGpio, CHANNEL, dataOut);
	}

	while(1);
}

