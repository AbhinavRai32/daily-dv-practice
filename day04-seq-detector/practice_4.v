`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2026 23:18:39
// Design Name: 
// Module Name: practice_4
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


module practice_4(
    input  wire clk,
    input  wire rst,     // async active-low reset
    input  wire din,       // serial input, 1 bit per clock
    output reg detected   // high for one cycle when 1011 is detected
);
localparam s0 = 3'b000;
localparam s1 = 3'b001;
localparam s2 = 3'b010;
localparam s3 = 3'b011;
localparam s4 = 3'b100;

reg[2:0] state,next_state;

// squential block
always@(posedge clk or negedge rst)
begin
if(rst)
begin
state<=next_state;
end
else
state<=s0;

end

//combinational block

always@(*)
begin
case(state)
//state1
s0 :if(din)
next_state=s1;
else 
begin
next_state=s0;
detected<=0;
end
//state2
s1 : if(din)
next_state=s1;
else
next_state=s2;

//state3
s2 : if(din)
next_state=s3;
else
next_state=s0;

//state3
s3 : if(din)
next_state=s4;
else
next_state=s2;

//state4
s4 : if(din)
begin
next_state=s1;
end
else
next_state=s2;

default : next_state=s0;
endcase

end

always@(*) detected = (state == s4);

endmodule
