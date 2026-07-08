//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 06.07.2026 19:41:08
//// Design Name: 
//// Module Name: tb_1
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module tb_1(

//    );
//    reg clk,rst,enb,up_down;
//    wire [3:0] counts;
//    practise_1 pfr(.clk(clk),
//                   .rst(rst),
//                   .enb(enb),
//                   .up_down(up_down),
//                   .countss(counts));
//     reg [3:0]count_internal;
     
//     initial
//     begin
//     {clk,rst,enb,up_down,count_internal}=0;
//     end 
     
//     // checking it task
//     task check();
//     begin
//     if(enb)
//     begin if(up_down)
     
//     count_internal=count_internal+1'b1;
//     else
//      count_internal=count_internal-1'b1;
//     end
    
//     $display ("count_internal=%h", count_internal);
    
//     end

//     endtask
//     // clk start
//      always #10 clk = ~clk;
//      initial 
//      begin
//      //rst
//      @(posedge clk); #1 rst = 1;
//       @(posedge clk);#1
//       rst=0;
//      // en=1 up 0 to 15
//         @(posedge clk);#1
//         enb=1;
//         up_down=1;
//         repeat(20)
//         begin
//         check ;
//         @(posedge clk);#1
//         compare_result(count_internal,counts);
//         end
               
//      // en=1 down 15 to 0   
//          @(posedge clk);#1
//          enb=1;
//          up_down=0;
//          repeat(20)
//          begin
//           check ();
//          @(posedge clk)#1
//         compare_result(count_internal,counts);
//          end
          
//        // en=0 hold
//           @(posedge clk);#1
//            enb=0;
//         up_down=1;
//         repeat(5)
//         begin
//          check ();
//          @(posedge clk)#1
//         compare_result(count_internal,counts);
//         end
         
//       // en=0 hold  
//         @(posedge clk);#1
//            enb=0;
//         up_down=0;
//         repeat(5)
//         begin
//          check ();
//          @(posedge clk)#1
//         compare_result(count_internal,counts);
//       end
//       end
       
       
//       task compare_result(input [3:0] expected_data,input [3:0] actual_data);
//        begin
//        if (expected_data === actual_data) begin
//            $display("[PASS] : expected=%h,actual_data=%h",  expected_data, actual_data);
//        end else begin
//            $display("[FAIL] : expected=%h,actual_data=%h", expected_data, actual_data);
//        end
//    end
       
//        endtask     

   
//endmodule
`timescale 1ns/1ps
module tb_1();

  reg clk, rst, enb, up_down;
  wire [3:0] count;

  practise_1 pfr(
    .clk(clk),
    .rst(rst),
    .enb(enb),
    .up_down(up_down),
    .countss(count)
  );

  reg [3:0] count_internal;

  // clock
  initial clk = 0;
  always #10 clk = ~clk;

  // reference model - direct module-scope access, no arguments
  task check;
  begin
    if (enb) begin
      if (up_down) count_internal = count_internal + 1;
      else         count_internal = count_internal - 1;
    end
    $display("count_internal=%h", count_internal);
  end
  endtask

  task compare_result(input [3:0] expected, input [3:0] actual);
  begin
    if (expected === actual)
      $display("[PASS] expected=%h, actual=%h", expected, actual);
    else
      $display("[FAIL] expected=%h, actual=%h", expected, actual);
  end
  endtask

  initial begin
    {rst, enb, up_down, count_internal} = 0;

    // reset
    @(posedge clk); #1;
    rst = 1; count_internal = 0;
    @(posedge clk); #1;
    rst = 0;

    // phase 1: enb=0, hold - count should not move
    @(posedge clk); #1
    enb = 0; up_down = 1;
    repeat(5) begin
      @(posedge clk); #1;
      check;
      compare_result(count_internal, count);
    end

    // phase 2: enb=1, up - wraparound 15->0 guaranteed
   @(posedge clk); #1
    enb = 1; up_down = 1;
    @(posedge clk); #1;
      repeat(17) begin
    check;
      @(posedge clk); #1;
      
      compare_result(count_internal, count);
    end

// recheck 
    @(posedge clk); #1;
    enb=0;
    check;
     compare_result(count_internal, count);
     
    // phase 3: enb=1, down - wraparound 0->15 guaranteed
    @(posedge clk); #1
 
    enb = 1; up_down = 0;
    repeat(16) begin
     check;
      @(posedge clk); #1;
     
      compare_result(count_internal, count);
    end

    // phase 4: enb=0, hold - count should freeze
    @(posedge clk); #1
    enb = 0;
    repeat(5) begin
      @(posedge clk); #1;
      check;
      compare_result(count_internal, count);
    end

    $display("Simulation done.");
    $finish;
  end

endmodule