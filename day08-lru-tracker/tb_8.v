`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: tb_8
// Fixed version - see comments marked FIX for what changed and why
//////////////////////////////////////////////////////////////////////////////////
module tb_8();
    reg clk,rst,access_en;
    reg [1:0] access_idx;
    wire [1:0] lru_idx;

    integer i,j;
    reg [1:0] expected_lru_idx;
    reg [1:0] expected_age[0:3];
    integer old_age;

    practice_8 ptr8(clk,rst,access_en,access_idx,lru_idx);

    // reference model
    task check();
    begin
        if(access_en) begin
            old_age = expected_age[access_idx];   // capture BEFORE any update this call
            for(i=0;i<4;i=i+1) begin
                if (i == access_idx)
                    expected_age[i] = 0;
                else if(expected_age[i] < old_age)   // FIX: compare against captured old_age,
                                                       // not the live (already-mutating) array element
                    expected_age[i] = expected_age[i] + 1;
            end
        end
        for (j = 0; j < 4; j = j + 1) begin
            if (expected_age[j] == 3)
                expected_lru_idx = j;
        end
    end
    endtask

    // mirrors DUT's async reset behavior - fires on the actual reset event,
    // not on some manually-timed task call
    always @(negedge rst) begin
        expected_age[0] = 0;
        expected_age[1] = 1;
        expected_age[2] = 2;
        expected_age[3] = 3;
        expected_lru_idx = 3;
    end

    initial begin
        {clk,access_en,access_idx,expected_lru_idx} = 0;
        rst = 1;
    end

    always #10 clk = ~clk;

    initial begin
        #1 rst = 0;
        #13 rst = 1;

        @(posedge clk); #1;
        access_en = 0;

        // access 1: idx=2
        @(posedge clk); #1;
        access_en = 1; access_idx = 2;
        check();
        @(posedge clk); #1;
        compare_result(expected_lru_idx, lru_idx);

        // access 2: idx=2 again (repeated-MRU case)
        @(posedge clk); #1;
        access_en = 1; access_idx = 2;
        check();
        @(posedge clk); #1;
        compare_result(expected_lru_idx, lru_idx);

        // access 3: idx=3
        @(posedge clk); #1;
        access_en = 1; access_idx = 3;
        check();
        @(posedge clk); #1;
        compare_result(expected_lru_idx, lru_idx);

        // mid-sequence reset - access_en dropped BEFORE reset so no
        // stray access gets consumed on the deassert edge
        access_en = 0;
        rst = 0;

        @(posedge clk); #1;
        rst = 1;

        @(posedge clk); #1;
        compare_result(expected_lru_idx, lru_idx);   // verify reset state itself, standalone

        // access 4: idx=0, access_en and access_idx set TOGETHER
        // FIX: previously access_en was raised one cycle before access_idx
        // was updated, so the DUT consumed a stray access with the old idx (3)
        @(posedge clk); #1;
        access_en = 1; access_idx = 0;
        check();
        @(posedge clk); #1;
        compare_result(expected_lru_idx, lru_idx);

        #30 $finish;
    end

    task compare_result(input [1:0] expected, input [1:0] actual);
    begin
        if(actual == expected)
            $display("MATCH HO GAYA");
        else
            $display("MATCH NHI HUA, expected=%0d actual=%0d time=%0t", expected, actual, $time);
    end
    endtask
endmodule