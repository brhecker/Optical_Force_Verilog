`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:02:32 12/08/2016
// Design Name:   Top_Module
// Module Name:   R:/MQP/MQP_FPGA_Interface/MQP_Test.v
// Project Name:  MQP_FPGA_Interface
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top_Module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MQP_Test;

	// Inputs
	reg fpga_clk;
	reg serial_data1;
	reg serial_data2;
	reg reset;
	reg [4:0]counter;
	reg en;

	// Outputs
	wire SI1;
	wire sensor_clk;
	wire ADC_clk;
	wire chip_select;
	wire [11:0] Data1;
	wire [11:0] Data2;
	wire clk_20M_out;

	// Instantiate the Unit Under Test (UUT)
	Top_Module uut (
		.fpga_clk(fpga_clk), 
		.serial_data1(serial_data1), 
		.serial_data2(serial_data2), 
		.reset(reset), 
		.SI1(SI1), 
		.sensor_clk(sensor_clk), 
		.ADC_clk(ADC_clk), 
		.chip_select(chip_select), 
		.Data1(Data1), 
		.Data2(Data2),
		.clk_20M_out(clk_20M_out)
	);
	
	always
	begin
		fpga_clk = 0;
		#5;
		fpga_clk = 1;
		#5;
	end
	
	always @(negedge chip_select)
	begin
		en <=1;
	end
	
	always @(negedge ADC_clk)
	begin
		if(en)
		begin
			/*if(counter > 12)
			begin
				serial_data1 <= 0;
				serial_data2 <= 0;
				counter <= counter-1'b1;
			end
 else*/ 	if(counter > 0)
			begin
				serial_data1 <= ~serial_data1;
				serial_data2 <= ~serial_data2;
				counter <= counter - 1'b1;
			end
			else
			begin
				en <= 0;
				counter <= 16;
			end
		end
	end
	
	initial begin
		// Initialize Inputs
		reset = 0;
		serial_data1 = 0;
		serial_data2 = 0;
		counter = 16;
		en = 0;
		

		// Wait 100 ns for global reset to finish
		reset = 1;
		#10;
		reset = 0;
		#5000000;
		reset = 1;
		#10;
      reset = 0;
	end
      
endmodule

