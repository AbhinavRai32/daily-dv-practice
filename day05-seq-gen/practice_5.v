`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2026 00:28:14
// Design Name: 
// Module Name: practice_5
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


module practice_5 #(parameter width = 8) (
    input clk,
    input rst_n,        // async active-low reset
    input load,          // synchronous: load new pattern, restart from MSB
    input hold,           // synchronous: freeze output, don't advance
    input [width-1:0] pattern_in,
    output reg bit_out,
    output reg [width-1:0] pattern_reg  // current stored pattern, for TB visibility
);
reg [$clog2(width)-1:0]ptr;

always@(posedge clk or negedge rst_n)
begin
if(rst_n==0)
begin
ptr<=width-1;
pattern_reg<=0;
end
else if(load)
begin
pattern_reg<=pattern_in;
ptr<=width-1;
end

else if(hold)
begin
ptr<=ptr;
end

else if (!hold&&!load)
begin
if(ptr==0)
ptr<=width-1;
else
ptr<=ptr-1;
end

end

always@(*)

  bit_out = (!rst_n) ? 0 : (load ? pattern_in[width-1] : pattern_reg[ptr]);endmodule
