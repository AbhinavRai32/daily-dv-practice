`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 15:49:11
// Design Name: 
// Module Name: practice_3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module practice_3 #(parameter width = 8)
(input [width-1:0] data_in ,
input [$clog2(width)-1:0]shift_amt,input dir,mode, output reg [width-1:0] data_out
);

always@(*)
begin
data_out=0;
if(mode&&dir)
 data_out = data_in>>shift_amt | data_in<<width-shift_amt;

if(mode&&!dir)
data_out = data_in <<shift_amt | data_in >> width-shift_amt;

if(!mode&&dir)
data_out =  data_in >> shift_amt;

if(!mode&&! dir)
data_out = data_in << shift_amt;


   end 
endmodule
