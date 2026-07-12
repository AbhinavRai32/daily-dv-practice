# daily-dv-practice
# Daily DV Practice

Self-checking RTL + testbench, one problem per day, part of my VLSI DV prep roadmap.

| Day | Topic | Status | Notes |
|-----|-------|--------|-------|
| 1 | Sync up/down counter | Done | Fixed race condition in TB reference model |
| 2 | Parameterized priority encoder | Done | Exhaustive 256-vector self-checking TB |
| 3 | barrell shift | Done | learn to apply use new way to check rather than dut way in refrence model |
| 4 | Moore FSM overlapping sequence detector (1011) | Done | Race condition (rst/posedge) fixed via reset guard;  |
| 5 | Programmable sequence generator (load/hold) | Done | Independent ref model, ptr indexing without shifting pattern_reg;  |