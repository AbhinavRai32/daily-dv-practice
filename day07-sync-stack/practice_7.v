`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 00:48:10
// Design Name: 
// Module Name: practice_7
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


module practice_7 #(parameter width=8,depth=16)(input clk,rst,push,pop,
                                                input [width-1:0]datain,
                                                output reg overflow,underflow,
                                                output reg [width-1:0]dataout,
                                                output wire full,empty,
                                                output reg [width-1:0] peek

    );
    
    reg [$clog2(depth+1)-1:0]top_ptr ;
    assign empty =(top_ptr==0);
    assign full = (top_ptr==depth);
    
    reg [width-1:0] mem [0:depth-1]; //2d array
    
    //sequential
    always@(posedge clk)
    begin
    
    //reset condition
    if(rst)
    begin
    dataout<=0;
    overflow<=0;
    underflow<=0;
    top_ptr<=0;
    end
    
    //push and pop simultaneously 
    else if(push&&pop&&!full&&!empty)
    begin
    mem[top_ptr-1]<=datain;
    dataout<=mem[top_ptr-1];
    end
    
    //push condition
    else if(push&&!full)
    begin
    mem[top_ptr]<=datain;
    top_ptr<=top_ptr+1'b1;
    end
    
    //pop condition
    else if(pop&&!empty)
    begin
    dataout<=mem[top_ptr-1];
    top_ptr<=top_ptr-1;
    end
    
    //overflow and underflow
   else
   begin
   if(push&&full)
    overflow<=1;
    if(pop&&empty)
    underflow<=1;
    end
    end
    
    //peek combinational block
    always@(*)
    if(rst)
    peek=0;
    else
    begin
    if(push==0||full)
    peek=mem[top_ptr-1];
    else
    peek=datain;
    end

endmodule
