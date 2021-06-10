################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/Utils.c \
../src/main.c \
../src/platform.c \
../src/rlc_coder.c \
../src/rlc_decoder.c 

OBJS += \
./src/Utils.o \
./src/main.o \
./src/platform.o \
./src/rlc_coder.o \
./src/rlc_decoder.o 

C_DEPS += \
./src/Utils.d \
./src/main.d \
./src/platform.d \
./src/rlc_coder.d \
./src/rlc_decoder.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../rlc_design_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


