`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2026 00:59:13
// Design Name: 
// Module Name: tb_5
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


module tb_5(


    );
    parameter width=8;
    reg clk,rst,hold,load;
    reg [width-1:0] pattern_in;
    
    wire bit_out;
    wire [width-1:0]pattern_reg;
    
    practice_5 ptr5(.clk(clk),
                    .rst_n(rst),
                    .hold(hold),
                    .load(load),
                    .pattern_in(pattern_in),
                    .bit_out(bit_out),
                    .pattern_reg(pattern_reg)
                    );
                    
      reg [$clog2(width)-1:0] ptr_expt;
      reg [width-1:0]expected_out;
      reg bit_expected_out;
      integer error_count;
      reg reset_done=0;
      
      always @(posedge rst) begin   // rst 0->1 hote hi (de-assert)
    reset_done = 1;
end
      
      always@(posedge clk or negedge rst)
      begin
      if(rst==0)
      begin
      
ptr_expt<=width-1;
expected_out<=0;
end
else if(load)
begin
expected_out<=pattern_in;
ptr_expt<=width-1;

end

else if (hold)
begin
ptr_expt<=ptr_expt;
end

else if(!hold&&!load)
begin
if(ptr_expt==0)
ptr_expt<=width-1;
else
ptr_expt<=ptr_expt-1;
end

      end
      
  always@(*)
  if(rst==0)
  bit_expected_out=0;
  else
  begin
   if(load)
  bit_expected_out= pattern_in[width-1];
  else
  bit_expected_out= expected_out[ptr_expt];
  end
  
  initial
  {clk,rst,pattern_in,expected_out,bit_expected_out,hold,load,ptr_expt,error_count}=0;
  
  always #10 clk=~clk;
  
  initial
  
  begin
  
  #1 rst=0;
 #9 rst=1;
 
 @(posedge clk);
 begin
 #2;
 pattern_in=8'b10010101;
 load=1;
 end
 
 @(posedge clk);
 #2;
 load=0;
 
 @(posedge clk)
 #2
 hold=1;
 
 @(posedge clk);
 #2;
 begin
 hold=0;
 load=0;
 end
 
 @(posedge clk);
 
 begin
 #2;
 hold=1;
 end
 
 @(posedge clk);
 #2;
 load=1;
 
  #20;
$display("Total errors = %0d", error_count);
$finish;
 
 
  end
  
   always @(negedge clk) begin
   if(reset_done)
   begin
   
    if (expected_out !== pattern_reg || bit_expected_out !== bit_out) begin
        $display("FAIL at time %0t: expected_out=%b, pattern_reg=%b, bit_expected_out = %b,bit_out=%b", $time, expected_out, pattern_reg,bit_expected_out,bit_out);
        error_count = error_count + 1;
        $display ("total error count=%d", error_count);
    end
    end
    end


endmodule
