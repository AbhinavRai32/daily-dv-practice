`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 17:30:02
// Design Name: 
// Module Name: tb_3
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


module tb_3(

    );
    parameter width=8;
    reg [width-1:0] datain;
    reg mode,direc;
    reg [$clog2(width)-1:0]shift_amt;
    wire [width-1:0] dataout;
    practice_3 pr3(.data_in(datain),
                    .mode(mode),
                    .dir(direc),
                    .shift_amt(shift_amt),
                    .data_out(dataout)
                    );
                    integer j;
                    integer total_pass;
                    reg [3:0] index;
        reg [width-1:0] expected_out;
        // task
        task give();
        begin
        if(mode&&direc)
        begin
for(j=0;j<width;j=j+1)
begin
index = (j + shift_amt) % width;
expected_out[j] = datain[index];
end
end

if(mode&&!direc)
 begin
for(j=0;j<width;j=j+1)
begin
index = (j - shift_amt+width) % width;
expected_out[j] = datain[index];
end
end

if(!mode&&direc)
expected_out =  datain >> shift_amt;

if(!mode&&! direc)
expected_out = datain << shift_amt; 
        end
        
        
        endtask
        
        //compare task
        task compare_result(input [width-1:0] expecteddata, input  [width-1:0] actualdata);
       begin
        if(expecteddata==actualdata)
        begin
        
        $display("PASS");
        
        end
        else
        $display("FAIL");
        end
        endtask
        //intantiate            
     initial
     {datain,mode,direc,shift_amt}=0;
     
     initial
     begin

 for (shift_amt = 0; shift_amt < width; shift_amt = shift_amt+1)
begin
datain=8'b10100011;
  mode=0; direc=0; #1 give; compare_result(expected_out,dataout);
      mode=0; direc=1; #1 give; compare_result(expected_out,dataout);
      mode=1; direc=0; #1 give; compare_result(expected_out,dataout);
      mode=1; direc=1; #1 give; compare_result(expected_out,dataout);
end  
   
#10 $finish;     
     end
                    
endmodule
