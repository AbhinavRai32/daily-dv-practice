`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2026 15:27:46
// Design Name: 
// Module Name: tb_4
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


module tb_4(

    );
    reg clk,rst,din;
    wire detected;
    
    practice_4 pr4(.clk(clk), .rst(rst) , .din(din) , .detected(detected));
    
    reg [3:0] shift_reg;
    reg expected_detected;
    integer error_count;
    
    initial
    begin
{din ,clk,shift_reg,error_count }=0;
{rst}=1;
end
always @(posedge clk or negedge rst) begin
    if (!rst)
        shift_reg <= 4'b0000;
    else
        shift_reg <= {shift_reg[2:0], din};
end

always @(*) 
    expected_detected = (shift_reg == 4'b1011);
    
    always #10 clk=~clk ;
    
    initial 
    begin
#1 rst=0;
#9 rst=1;
 
 @(posedge clk);
 
 // clean phase

 din=1'b1;
@(posedge clk)
 din=1'b0;
 @(posedge clk)
 din=1'b1;
@(posedge clk)
 din=1'b1;
 
 //overlap phase

 @(posedge clk)

 din=1'b1;
 
 @(posedge clk)
 din=1'b0;
 
 @(posedge clk)
 din=1'b1;
 @(posedge clk)
 rst=0;
 @(posedge clk)
 rst=1;
 @(posedge clk)
 din=1'b1;
 
  @(posedge clk)
 din=1'b0;
 
  @(posedge clk)
 din=1'b1;
 
  @(posedge clk)
 din=1'b1;
 

 // near miss case
 @(posedge clk)

 din=1'b1;
 
  @(posedge clk)
 din=1'b0;
 
  @(posedge clk)
 din=1'b1;
 
 
 
  @(posedge clk)
 din=1'b0;
 
 #20;
$display("Total errors = %0d", error_count);
$finish;
 
 end


    always @(negedge clk) begin
    if (detected !== expected_detected) begin
        $display("FAIL at time %0t: DUT=%b, Expected=%b", $time, detected, expected_detected);
        error_count = error_count + 1;
        $display ("total error count=%d", error_count);
    end
    end





    
endmodule
