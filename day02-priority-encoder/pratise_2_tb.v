`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2026 19:50:43
// Design Name: 
// Module Name: pratise_2_tb
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


module pratise_2_tb(

    );
    parameter width=8;
    reg [7:0] in;
    
    reg rst;
    wire valid ;
    integer i;
    integer m;
    reg expected_valid;
    reg [3:0]expected_out;
    integer pass_count,fail_count,pass_count_out,fail_count_out;
    wire [2:0] out ;
    practise_2 pr2(.in(in),.rst(rst),.valid(valid),.out(out));
    
    //task for valid 
    task check();
    if(in!=0)
    expected_valid=1;
    else 
    expected_valid=0;
    endtask
    
    // task for out
    task outcheck();
    begin
    expected_out=0;
    for(m=width-1;m>=0;m=m-1)
    begin
    if(in[m]==1)
    expected_out=m;
    end
    end
    endtask
    
    //compare
    task compare_result(input actualvalid,input expectedvalid, input [3:0]actualout, input [3:0]expectedout);
    begin
    if(actualvalid==expectedvalid)
    begin
    $display("VALID PASS : EXPECTED VALID = %b, ACTUAL VALID =%b",expectedvalid,actualvalid);
    pass_count=pass_count+1;
    end
    else
    begin
    $display("VALID FAIL");
    fail_count=fail_count+1;
    end
    // for output 
    
    if(actualout==expectedout)
    begin
        $display("VALID PASS : EXPECTED out = %b, ACTUAL out =%b",expectedout,actualout);
        pass_count_out=pass_count_out+1;
        end
         else
         begin
    $display("out FAIL");
    fail_count_out=fail_count_out+1;
    end
    end
    endtask
    
    //intiantiate 
   initial
    {in,pass_count,fail_count,pass_count_out,fail_count_out}=0;
    
    // begin
    initial 
    begin
    #1 rst=1;
    #1 rst=0;
    #1
    for(i=0;i<256;i=i+1)
    begin
    
    in=i;
    check;
    outcheck;
      #1
    compare_result(valid,expected_valid,out,expected_out);
    end
  $display("TOTAL PASS VALID = %d , TOTAL PASS OUT = %d , TOTAL FAIL VALID =%d , TOTAL FAIL OUT =%d", pass_count,pass_count_out,fail_count,fail_count_out);
    
    
    #10 $finish;
    end
    
    
endmodule
