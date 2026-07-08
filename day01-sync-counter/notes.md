# Day 2: Parameterized Priority Encoder

Exhaustive 256-vector self-checking testbench.

**Bugs caught:**
- Loop bound off-by-one (started at width instead of width-1) — undefined bit read
- Priority-hold logic broken initially — later loop iterations overwrote correct match
- Latch inferred due to missing default assignment before the loop
- Same off-by-one bug repeated in the reference model's scan loop
- Pass/fail counters uninitialized, causing X propagation in final summary

**Fix pattern:** default-before-loop + disable-block for early termination on match.



# Day 1: Synchronous Up/Down Counter

Self-checking testbench with reference model tracking expected count.

**Bugs caught:**
- Testbench had a race condition around clock edge sampling
- Fixed using @(posedge clk); #1 settle pattern

**Key concept:** reference model must be independent of DUT logic to catch real bugs.

