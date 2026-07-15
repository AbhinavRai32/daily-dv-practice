`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 09:24:59
// Design Name: 
// Module Name: tb_7
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


module tb_7(

    );
    parameter width=8;
    parameter depth=16;
    
    reg clk,rst,push,pop;
    reg [width-1:0] datain;
    wire full,empty,overflow,underflow;
    wire [width-1:0] dataout,peek;
    
    reg [width-1:0] expected_out,expected_peek;
    reg expected_overflow,expected_underflow;
    reg [width-1:0] ref_mem[0:depth-1];
    reg  [$clog2(depth+1)-1:0]expected_ptr;
    
    practice_7 ptr7(.clk(clk),.rst(rst),.push(push),.pop(pop),.datain(datain),.full(full)
    ,.empty(empty),.overflow(overflow),.underflow(underflow),.peek(peek),.dataout(dataout));
    
    task pus();
    if(push)
    begin
    if(!full)
    begin
    ref_mem[expected_ptr]=datain;
    expected_ptr=expected_ptr+1;
    end
    else
    expected_overflow=1;
    end
    endtask
    
    task poop();
    if(pop)
    begin
    if(!empty)
    begin
    expected_out=ref_mem[expected_ptr-1];
    expected_ptr=expected_ptr-1;
    end
    else
    expected_underflow=1;
    end
    endtask
    
    task simul_push_pop();
    if(push && pop && !full && !empty)
    begin
    expected_out = ref_mem[expected_ptr-1];  // purana top, pointer move se pehle
    ref_mem[expected_ptr-1] = datain;         // same slot overwrite
   // expected_ptr yahan change NAHI hota
end
endtask

task calc_expected_peek();
if(push && !full)
  expected_peek = datain;              // naya top, push ho raha hai
else
  expected_peek = ref_mem[expected_ptr-1];  // purana top, push nahi/blocked
endtask

initial
{clk,rst,datain,push,pop,expected_overflow,expected_underflow,expected_ptr,expected_out,expected_peek}=0;
   
   
   always #10 clk=~clk;
   
   
initial
begin 
  #1rst=1;
   # 16 rst=0; 
   expected_peek=0;
   
   $display ("/n====filling stack====/n"); 
    // filling stack with datain
    @(posedge clk); #1;
    datain=8'haa; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered(); 
    push=0;
    
      @(posedge clk); #1;
    datain=8'hab; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 
    
      @(posedge clk); #1;
    datain=8'hac; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 
    
      @(posedge clk); #1;
    datain=8'had; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 
    
      @(posedge clk); #1;
    datain=8'hae; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 
    
      @(posedge clk); #1;
    datain=8'haf; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 
    
      @(posedge clk); #1;
    datain=8'hba; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0;
    
      @(posedge clk); #1;
    datain=8'hbb; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0;

    
      @(posedge clk); #1;
    datain=8'hbc; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0;

    
      @(posedge clk); #1;
    datain=8'hbd; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 

    
      @(posedge clk); #1;
    datain=8'hbe; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 

    
      @(posedge clk); #1;
    datain=8'hbf; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 

    
      @(posedge clk); #1;
    datain=8'hca; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 

    
     @(posedge clk); #1;
    datain=8'hcb; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 

    
     @(posedge clk); #1;
    datain=8'hcc; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 

    
     @(posedge clk); #1;
    datain=8'hcd; 
    push=1;
    #1
    calc_expected_peek();
    pus();
    check_all();
    @(posedge clk) #1;
    check_registered();push=0; 

    
    $display("ptr_bits = %d , overflow =%b,underflow=%b/n",expected_ptr,expected_overflow,expected_underflow);
    
    $display("/n===pop start===/n");
    @(posedge clk);// two extra latency for settlimg down data safe 
    @(posedge clk);
    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0;

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0;

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0;

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0;
    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0;

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    @(posedge clk);#1;
    pop=1;
    calc_expected_peek();
    poop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();pop=0; 

    
    
 $display("ptr_bits = %d , overflow =%b,underflow=%b/n",expected_ptr,expected_overflow,expected_underflow);

$display("/n===simultaneously push pop==/n");
@(posedge clk);//again safe latency of 1 cycle

@(posedge clk);#1;
datain=8'h9c;
push=1;
#1
calc_expected_peek();
pus();
    check_all();
    @(posedge clk) ;#1;
    check_registered(); 

    
    @(posedge clk);#1;
datain=8'h9f;
push=1;
#1
calc_expected_peek();
pus();
    check_all();
    @(posedge clk) ;#1;
    check_registered();

    
    @(posedge clk);#1;
datain=8'h9e;
push=1;
#1
calc_expected_peek();
pus();
    check_all();
    @(posedge clk) ;#1;
    check_registered(); 

    
    @(posedge clk);#1;
datain=8'h9d;
push=1;
#1
calc_expected_peek();
pop=1;
simul_push_pop();
    check_all();
    @(posedge clk) ;#1;
    check_registered(); 

    
    @(posedge clk);#1;
datain=8'h9b;
push=1;
pop=1;
#1
calc_expected_peek();
simul_push_pop();
    check_all();
    @(posedge clk) ;#1;
    check_registered(); 

    
    @(posedge clk);#1;
datain=8'h9a;
push=1;
pop=1;
#1
calc_expected_peek();
simul_push_pop();
    check_all();
    @(posedge clk) ;#1;
    check_registered();
   

    
  #30
    $finish;
    
    end
    
    
    task check_all();
begin
  // peek check - SAME cycle, comb hai
  if(peek !== expected_peek)
    $display("MISMATCH: peek. Expected=%h Got=%h Time=%0t/n", expected_peek, peek, $time);
  else 
    $display("MATCH: peek. Expected=%h Got=%h Time=%0t/n", expected_peek, peek, $time);

end
endtask

task check_registered();
begin
  if(dataout !== expected_out)
    $display("MISMATCH: dataout.../n");
    else
    $display("MATCH: dataout. EXPECTED=%h GOT=%h/n",expected_out,dataout);
  if(overflow !== expected_overflow)
    $display("MISMATCH: overflow.../n");
     else
    $display("MATCH: overflow. EXPECTED=%h GOT=%h/n",expected_overflow,overflow);
  if(underflow !== expected_underflow)
    $display("MISMATCH: underflow.../n");
     else
    $display("MATCH: underflow. EXPECTED=%h GOT=%h/n",expected_underflow,dataout);
end
endtask

endmodule
