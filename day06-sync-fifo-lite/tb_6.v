`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 11:40:00
// Design Name: 
// Module Name: tb_6
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


module tb_6(

    );

    // DUT signals
    reg clk, rst, rd_en, wr_en;
    reg [7:0] datain;
    wire [7:0] dataout;
    wire  overflow, underflow, empty, full;

    // Reference model
    reg [7:0] ref_queue[0:15];
    integer head, tail, count;
    reg [7:0] expected_data;
  
    // DUT instantiation
    practice_6 ptr (
        .clk(clk),
        .rst(rst),
        .datain(datain),
        .rd_en(rd_en),
        .wr_en(wr_en),
        .dataout(dataout),
        .overflow(overflow),
        .underflow(underflow),
        .empty(empty),
        .full(full)
       
    );


    task ref_push(input [7:0] data);
    begin
        if (count < 16) begin
            ref_queue[tail] = data;
            tail = (tail + 1) % 16;
            count = count + 1;
            $display("[REF] PUSH: data=%h, tail now=%d, count=%d", data, tail, count);
        end else begin
            $display("[REF] ERROR: PUSH called on full FIFO! Ignoring.");
        end
    end
    endtask

    task ref_pop(output [7:0] data_out);
    begin
        if (count > 0) begin
            data_out = ref_queue[head];
            head = (head + 1) % 16;
            count = count - 1;
            $display("[REF] POP: data=%h, head now=%d, count=%d", data_out, head, count);
        end else begin
            $display("[REF] ERROR: POP called on empty FIFO! Returning X");
            data_out = 8'hXX;
        end
    end
    endtask
    


    // ============================================
    // CLOCK GENERATION
    // ============================================
    always #10 clk = ~clk;

    // ============================================
    // MAIN TEST
    // ============================================
    initial
    begin
        // Initialize
        clk = 0;
        rst = 0;
        rd_en = 0;
        wr_en = 0;
        datain = 0;
        head = 0;
        tail = 0;
        count = 0;
        expected_data=0;

        // Reset
        @(posedge clk);
        rst = 0;
        @(posedge clk);
        rst = 1;
        $display("\n===== FIFO TEST START =====\n");

        // ===== WRITE PHASE =====
        $display("\n----- WRITE PHASE -----");
        
        // Write 1
        @(posedge clk) #1;
        datain = 8'hAA;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;

        // Write 2
        @(posedge clk) #1;
        datain = 8'hBB;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;


        // Write 3
        @(posedge clk) #1;
        datain = 8'hCC;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;

        // Write 4
        @(posedge clk) #1;
        datain = 8'hDD;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        


        // Write 5
        @(posedge clk) #1;
        datain = 8'hEE;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        


        // Write 6
        @(posedge clk) #1;
        datain = 8'hFF;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        


        // Write 7
        @(posedge clk) #1;
        datain = 8'h11;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
      


        // Write 8
        @(posedge clk) #1;
        datain = 8'h22;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
       
         
        //data 9
        @(posedge clk) #1;
        datain = 8'h2A;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        

        
        //data10
         @(posedge clk) #1;
        datain = 8'h2B;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        

        
        //data11
         @(posedge clk) #1;
        datain = 8'h32;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        

        
        //data12
         @(posedge clk) #1;
        datain = 8'h62;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        

        
        //data13
         @(posedge clk) #1;
        datain = 8'h22;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        

        
        //data14
         @(posedge clk) #1;
        datain = 8'hBA;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        

        
        //data15
         @(posedge clk) #1;
        datain = 8'hCF;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;


        
        //data16
         @(posedge clk) #1;
        datain = 8'hDE;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
  

        
        $display("\n[STATUS] After writes: ref_count=%d, empty=%b, full=%b\n", count, empty, full);
        
          @(posedge clk) #1;
        datain = 8'h33;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
        
          @(posedge clk) #1;
        datain = 8'h44;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;
          $display("\n[STATUS] After writes: ref_count=%d, empty=%b, full=%b\n, overflow=%d\n", count, empty, full,overflow);

        // ===== WAIT BEFORE READING =====
        @(posedge clk) #1;
        @(posedge clk) #1;

        // ===== READ PHASE =====
        $display("\n----- READ PHASE -----");

        // Read 1
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;
         

        // Wait for registered output (1-edge delay from your RTL structure)
        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 1");

        // Read 2
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;
        

        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 2");

        // Read 3
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;
        

        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 3");

        // Read 4
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;
         

        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 4");

        // Read 5
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;


        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 5");

        // Read 6
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;
        

        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 6");

        // Read 7
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;


        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 7");

        // Read 8
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;


        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 8");
        
        //READ9
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;


        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 9");
        
        //READ10
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;


        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 10");
        
        //READ11
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;


        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 11");
        
        //READ12
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;


        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 12");
        
        //READ13
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;


        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 13");
        
        //READ14
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;
         

        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 14");
        
        //READ15
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;
        
        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 15");
        
        //READ16
        @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
        ref_pop(expected_data);
        rd_en = 0;
       

        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read 16");
        

        $display("\n[STATUS] After reads: ref_count=%d, empty=%b, full=%b\n", count, empty, full);
        
          @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
     
        rd_en = 0;
        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read x");
        
          @(posedge clk) #1;
        rd_en = 1;
        @(posedge clk) #1;
      
        rd_en = 0;
        @(posedge clk) #1;
        compare_result(expected_data, dataout, "Read x");
        
         $display("\n[STATUS] After reads: ref_count=%d, empty=%b, full=%b\n,underflow=%d\n", count, empty, full,underflow);
        
        // ===== SIMULTANEOUS READ-WRITE TEST =====
        $display("\n----- SIMULTANEOUS READ-WRITE TEST -----");

        // Write new data
        @(posedge clk) #1;
        datain = 8'h33;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;

        // Write more
        @(posedge clk) #1;
        datain = 8'h44;
        wr_en = 1;
        @(posedge clk) #1;
        ref_push(datain);
        wr_en = 0;

        // Simultaneous read+write
        @(posedge clk) #1;
        rd_en = 1;
        wr_en = 1;
        datain = 8'h55;
        @(posedge clk) #1;
        ref_pop(expected_data);
        ref_push(datain);
        rd_en = 0;
        wr_en = 0;
        @(negedge clk) #1;
        compare_result(expected_data, dataout, "SimRead 1");

        @(posedge clk) #1;
        $display("\n===== FIFO TEST END =====\n");

        $finish;
    end

    // ============================================
    // HELPER FUNCTION FOR COMPARISON
    // ============================================
    task compare_result(input [7:0] expected, input [7:0] actual, input test_name);
    begin
        if (expected === actual) begin
            $display("[PASS] %s: expected=%h, got=%h", test_name, expected, actual);
        end else begin
            $display("[FAIL] %s: expected=%h, got=%h", test_name, expected, actual);
        end
    end
    endtask

endmodule
