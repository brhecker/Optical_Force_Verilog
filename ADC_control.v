`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:23:03 12/06/2016 
// Design Name: 
// Module Name:    ADC_control 
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
module ADC_control(
    input Data1,
    input Data2,
	 input clk_20M,
	 input sensor_clk,
	 input sample_control,
     input reset,
    output ADC_clk,
    output chip_select,
    output reg [11:0] pdata1,
    output reg [11:0] pdata2
    );
	 reg [6:0]cntr = 0;
    //reg [3:0]dvder = 0;
	 reg [4:0]sdata_cntr = 0;
	 reg chip_sel_en = 0;
	 reg data_in_en = 0;
	 reg [15:0]shift_in1 = 0;
	 reg [15:0]shift_in2 = 0;
	 
	 
	 assign chip_select = (sensor_clk & chip_sel_en);
    assign ADC_clk = clk_20M;
	 
	 //Asyncronous Reset Logic
	 always @(posedge reset)
	 begin
//		   dvder <= 0;
			cntr <= 0;
			chip_sel_en <= 0;
			data_in_en <= 0;
			shift_in1 <= 16'b0;
			shift_in2 <= 16'b0;
	 end

	//Enable ADC Sampling for 128 Sensor Clock Cycles
	 always @(posedge sensor_clk)
		if(chip_sel_en)
		begin
			if(cntr>0)
				cntr <= cntr - 1'b1;
			else
				chip_sel_en <= 0;
		end
		
		//Enable ADC Sampling and start count down
		always @(posedge sample_control)
		begin
			chip_sel_en <= 1'b1;
			cntr <= 7'd127;
		end

		//ADC clocking logic
		/*always @(posedge clk_3M)
        if(dvder == 4)
            dvder <=0;
        else
            dvder <= dvder + 1'b1;*/
		
		//Enable Serial Data Input from ADC
		always @(negedge chip_select)
			data_in_en <= 1;
				
		//Shift in data from ADC	
		always @(posedge ADC_clk)
			if(data_in_en)
			begin
				if(sdata_cntr == 5'd16)
				begin
					pdata1 <= shift_in1[11:0];
					pdata2 <= shift_in2[11:0];
					sdata_cntr <= 0;
					data_in_en <= 0;
					shift_in1 <= 16'b0;
					shift_in2 <= 16'b0;
				end
				else
				begin
					shift_in1 <= {shift_in1[14:0], Data1};
					shift_in2 <= {shift_in2[14:0], Data2};
					sdata_cntr <= sdata_cntr + 1'b1;
				end
			end
endmodule
