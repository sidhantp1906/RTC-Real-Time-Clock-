`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:18:01 12/04/2021 
// Design Name: 
// Module Name:    rtc 
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
module rtc(
    output [4:0] hrs,
    output [5:0] mins,
    output [5:0] sec,
    input clk60ns,clk1ns,reset
    );
	 
	 reg [4:0]hrs_reg;
	 reg [5:0]mins_reg,mins_reg1,sec_reg;

	 
	 always @(posedge clk60ns)
	 begin
	 if(reset)
	 begin
	 hrs_reg = 5'b00000;
	 mins_reg = 6'b000000;
	 sec_reg = 6'b000000;
	 end
	 else
	 begin
	mins_reg = (mins_reg == 6'b111011)?6'b000000:mins_reg + 6'b000001;
	 repeat(59) @(posedge clk1ns);
	 end
	 end


always @(mins_reg)
begin
hrs_reg = (hrs_reg == 5'b10111)?5'b000000:hrs_reg + 5'b00001;
	repeat(59) @(posedge clk60ns);
end

always @(posedge clk1ns)
begin
sec_reg = (sec_reg == 6'b111011)?6'b000000:sec_reg + 6'b000001;
end
 
	 
	 assign hrs = hrs_reg;
	 assign mins = mins_reg;
	 assign sec = sec_reg;
	 


endmodule
