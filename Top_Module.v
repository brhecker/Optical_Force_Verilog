`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:30:40 11/28/2016 
// Design Name: 
// Module Name:    Top_Module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top_Module(
	input fpga_clk,
	input serial_data1,
	input serial_data2,
	input reset,
	input rx,
	output tx,
	output SI1,
	output sensor_clk,
	output ADC_clk,
	output chip_select,
	output clk_20M_out
    );
	 wire clk_20M;
	 wire clk_100M;
	 wire lock;
	 wire sample_control_signal;
	 wire fake_reset = 0;
	 wire [11:0]Data1;
	 wire [11:0]Data2;
	 
	 assign SI1 = sample_control_signal;
	 assign clk_20M_out = clk_20M;
	 
	 Serial_Sample_Control sample_control(sensor_clk, reset, sample_control_signal);
	 
	 sensor_clk_divider scd(clk_20M, reset, sensor_clk);
	 
	 ADC_control ADC1(serial_data1,
    serial_data2,
	 clk_20M,
	 sensor_clk,
	 sample_control_signal,
    reset,
    ADC_clk,
    chip_select,
    Data1,
    Data2
    );
	 
	DCM_MQP clock_manager
   (// Clock in ports
    .CLK_IN1(fpga_clk),      // IN
    // Clock out ports
    .CLK_OUT1(clk_100M),     // OUT
    .CLK_OUT2(clk_20M),     // OUT
    // Status and control signals
    .RESET(fake_reset),// IN
    .LOCKED(lock));

		
	Microblaze_Softcore softcore1 (
	 .Clk(clk_100M), // input Clk
	 .Reset(reset), // input Reset
	 .UART_Rx(rx), // input UART_Rx
	 .UART_Tx(tx), // output UART_Tx
	 .GPI1(Data1), // input [11 : 0] GPI1
	 .GPI1_Interrupt(), // output GPI1_Interrupt
	 .GPI2(Data2), // input [11 : 0] GPI2
	 .GPI2_Interrupt() // output GPI2_Interrupt
);


endmodule
