`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:12:40 12/08/2016
// Design Name:   ADC_control
// Module Name:   R:/MQP/MQP_FPGA_Interface/ADC_control_test.v
// Project Name:  MQP_FPGA_Interface
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ADC_control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ADC_control_test;

	// Inputs
	reg Data1;
	reg Data2;
	reg clk_3M;
	reg sensor_clk;
	reg sample_control;
	reg reset;
	reg [3:0]counter;
	reg en;

	// Outputs
	wire ADC_clk;
	wire chip_select;
	wire [11:0] pdata1;
	wire [11:0] pdata2;

	// Instantiate the Unit Under Test (UUT)
	ADC_control uut (
		.Data1(Data1), 
		.Data2(Data2), 
		.clk_3M(clk_3M), 
		.sensor_clk(sensor_clk), 
		.sample_control(sample_control), 
		.reset(reset), 
		.ADC_clk(ADC_clk), 
		.chip_select(chip_select), 
		.pdata1(pdata1), 
		.pdata2(pdata2)
	);
	
	always
	begin
		clk_3M = 0;
		#160;
		clk_3M = 1;
		#160;
	end
	
	always
	begin
		sensor_clk = 0;
		#31840;
		sensor_clk = 1;
		#160;
	end

	always @(posedge chip_select)
	begin
		en <=1;
	end
	
	always @(negedge ADC_clk)
	begin
		if(en)
		begin
			if(counter > 0)
			begin
				Data1 <= ~Data1;
				Data2 <= ~Data2;
				counter <= counter - 1'b1;
			end
			else
			begin
				en <= 0;
				counter <= 15;
			end
		end
	end

	initial begin
		// Initialize Inputs
		Data1 = 0;
		Data2 = 0;
		clk_3M = 0;
		sensor_clk = 0;
		sample_control = 0;
		reset = 0;
		counter = 15;
		en = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		reset = 1;
		#10
		reset = 0;
		// Add stimulus here
		#31730;
		sample_control = 1;
		#32000;
		sample_control = 0;

	end
      
endmodule

