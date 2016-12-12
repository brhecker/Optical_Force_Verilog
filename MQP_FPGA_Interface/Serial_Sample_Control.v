`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:36:09 11/30/2016 
// Design Name: 
// Module Name:    Serial_Sample_Control 
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
module Serial_Sample_Control(
    input sensor_clk,
	 input reset,
    output serial_out
    );
	reg [8:0]cntr = 0;
	
	//Asynchronous reset
	always @(posedge reset)
		cntr <= 0;
	
	//Start Sample Cycle Every 129 Clock cycles
	always @(negedge sensor_clk)
		if(cntr == 128)
			cntr <= 0;
		else
			cntr <= cntr +1'b1;
	
	assign serial_out = (cntr == 1);

endmodule
