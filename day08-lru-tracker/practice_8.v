`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 22:30:27
// Design Name: 
// Module Name: practice_8
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


module practice_8 #(width=4)(
    input        clk,
    input        rst,      // async active-low reset
    input        access_en,  // pulse: one of the 4 lines was accessed this cycle
    input  [1:0] access_idx, // which line (0-3) was accessed
    output reg [1:0] lru_idx     // index of the current least-recently-used line
);

reg [1:0] age [0:3];
integer i;
always@(posedge clk or negedge rst)
begin
if(rst==0)
begin
age[0]<=0;
age[1]<=1;
age[2]<=2;
age[3]<=3;
end
else if(access_en)
begin
for(i=0;i<4;i=i+1)
begin
 if (i == access_idx)
 age[i] <= 0;

else if(age[i]<age[access_idx])
age[i]<=age[i]+1;

end
end
end

integer j;
always @(*) begin
    lru_idx = 0; // default/safe value
    for (j = 0; j < 4; j = j + 1) begin
        if (age[j] == 3)
            lru_idx = j;   // jis line ka age 3 hai, USKA INDEX chahiye - j, na ki age[3]
    end
end

endmodule