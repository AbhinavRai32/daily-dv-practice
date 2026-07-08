`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 19:19:37
// Design Name: 
// Module Name: practise_1
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


module practise_1(input clk,rst,enb,up_down,output reg [3:0]countss) 

    ;
    
   always@(posedge clk)
   begin
   
   if(rst)
   countss<=4'b0;
   else 
   if(enb==0)
   countss<=countss;
    else if(up_down)
    countss<=countss+1'b1;
    else if(~up_down)
    countss<=countss-1'b1;
    end
endmodule
