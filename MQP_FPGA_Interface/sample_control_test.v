`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:19:11 11/30/2016
// Design Name:   Serial_Sample_Control
// Module Name:   R:/MQP/MQP_FPGA_Interface/sample_control_test.v
// Project Name:  MQP_FPGA_Interface
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Serial_Sample_Control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sample_control_test;

	// Inputs
	reg sensor_clk;

	// Outputs
	wire serial_out;

	// Instantiate the Unit Under Test (UUT)
	Serial_Sample_Control uut (
		.sensor_clk(sensor_clk), 
		.serial_out(serial_out)
	);
	
	always
	begin
		sensor_clk = 0;
		#16;
		sensor_clk = 1;
		#16;
	end

	initial begin
		// Initialize Inputs
		sensor_clk = 0;

		// Wait 100 ns for global reset to finish
		#20000;
        
	end
      
endmodule

