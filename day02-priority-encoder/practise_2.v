`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2026 19:08:34
// Design Name: 
// Module Name: practise_2
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


module practise_2#(parameter width=8

    )(input [width-1:0] in,
    input rst, output  reg [$clog2(width)-1:0] out,
    output reg valid );
    integer i;
   always@(*)
   begin
   if(rst)
   begin
   
   out=0;
   valid=0;
   end
   else
   begin
   
   out=0;
   valid=0;
   
   begin
    for (i=width-1; i>=0 ;i=i-1)begin:search
    begin
    if(in[i]==1)
    begin
    
    out=i;
    valid=1;
    disable search;
    end
  end
    end
    end
    end
    end
endmodule
