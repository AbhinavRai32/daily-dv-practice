`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 10:30:24
// Design Name: 
// Module Name: practice_6
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


module practice_6 #(parameter width=8, parameter depth=16

    )(input clk,rst,[width-1:0]datain,
    input rd_en,wr_en,output reg overflow,underflow,output wire full,empty,output reg [width-1:0] dataout);

localparam addr_bits=$clog2(depth);//8->3
localparam ptr_bits=addr_bits+1; //3+1=4

reg [ptr_bits-1:0] wptr,rptr;//4 bits pointer

reg [width-1:0] mem[0:depth-1];// memory array

// lower msb k liye 
wire [addr_bits-1:0]wptrd=wptr[ptr_bits-2:0];
wire [addr_bits-1:0]rptrd=rptr[ptr_bits-2:0];

// full empty condition
assign empty=(wptr==rptr);
assign full = (wptr[ptr_bits-1]!=rptr[ptr_bits-1]&&wptrd==rptrd);

//reset condition
always@(posedge clk or negedge rst)
if(rst==0)
begin
dataout<=0;
overflow<=0;
underflow<=0;
rptr<=0;
wptr<=0;
end

//read and write simultaneously with full and empty =0
else if(wr_en&&rd_en&&!full&&!empty)
begin
mem[wptr[ptr_bits-2:0]]<=datain;
wptr<=wptr+1'b1;
dataout<=mem[rptr[ptr_bits-2:0]];
rptr<=rptr+1'b1;
end
// read and write simultaneously with full only
else if(wr_en&&rd_en&&full&&!empty)
begin
mem[wptr[ptr_bits-2:0]]<=datain;
wptr<=wptr+1'b1;
dataout<=mem[rptr[ptr_bits-2:0]];
rptr<=rptr+1'b1;
end

//// read and write with empty only block reading 
else if(wr_en&&empty&&rd_en&&!full)
begin
mem[wptr[ptr_bits-2:0]]<=datain;
wptr<=wptr+1'b1;
underflow<=1;
end

//write condition 
else if(wr_en&&!full)
begin
mem[wptr[addr_bits-1:0]]<=datain;
wptr<=wptr+1'b1;
end
//read condition
else if(rd_en&&!empty)
begin
 dataout<= mem[rptr[addr_bits-1:0]];
rptr<=rptr+1'b1;
end
//overflow/underflow sticky flags
 else begin
        if(wr_en && full)
            overflow <= 1;
        else if(!full)          // ← clear condition add karo
            overflow <= 0;
            
        if(rd_en && empty)
            underflow <= 1;
        else if(!empty)         // ← clear condition add karo
            underflow <= 0;
    end

endmodule
