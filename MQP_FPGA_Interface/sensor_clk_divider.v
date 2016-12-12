`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:28:50 12/01/2016 
// Design Name: 
// Module Name:    sensor_clk_divider 
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
module sensor_clk_divider(
    input clk_3M,
	 input reset,
    output sensor_clk
    );
	reg [5:0]cntr = 0;
	
	assign sensor_clk = (cntr == 19);
	
	//Asynchronous Reset
	always @(posedge reset)
		cntr <= 0;
	
	//Divide 3.125MHz clock to 31.25KHz
	always @(posedge clk_3M)
		if (cntr == 6'd19)
			cntr <= 0;
		else
			cntr <= cntr + 1'b1;

endmodule
