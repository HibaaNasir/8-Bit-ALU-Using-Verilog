# 8-Bit ALU Design Using Verilog

## Overview
This project implements an 8-bit combinational Arithmetic Logic Unit (ALU) using Verilog HDL. A 3-bit opcode selects one of eight operations. The design produces an 8-bit result and three status outputs: carry, signed overflow, and zero.

## Supported operations

| Opcode | Operation | Description |
|---|---|---|
| `000` | ADD | A + B |
| `001` | SUB | A - B |
| `010` | AND | Bitwise AND |
| `011` | OR | Bitwise OR |
| `100` | XOR | Bitwise XOR |
| `101` | NOT | Bitwise complement of A |
| `110` | SHL | Shift A left by one bit |
| `111` | SHR | Shift A right by one bit |

## Interface
- Inputs: `A[7:0]`, `B[7:0]`, `opcode[2:0]`
- Outputs: `result[7:0]`, `carry`, `overflow`, `zero`

## Status flag definitions
- **Carry:** The ninth bit of the unsigned addition result. It is zero for operations other than ADD in this implementation.
- **Overflow:** Signed two's-complement overflow for ADD and SUB. It is zero for other operations.
- **Zero:** High when the 8-bit result equals zero.

## Files
- `design.v` — synthesizable combinational ALU RTL.
- `testbench.v` — self-checking simulation testbench.
- `block_diagram.png` — high-level architecture diagram.

## Run the simulation
1. Open [EDA Playground](https://www.edaplayground.com/).
2. Select Verilog and Icarus Verilog.
3. Paste `design.v` into the design editor.
4. Paste `testbench.v` into the testbench editor.
5. Enable **Open EPWave after run** if you want to inspect waveforms.
6. Click **Run**. The testbench writes `dump.vcd` and reports PASS/FAIL for 11 test cases.

## Verification
The included testbench checks all eight opcodes with sample inputs and tests three important boundary conditions:
- `8'hFF + 8'h01` — unsigned carry.
- `8'h7F + 8'h01` — signed positive overflow.
- `8'h80 - 8'h01` — signed negative overflow.

The simulation screenshot supplied during development showed 11 tests passed and 0 failed. Re-run the testbench in your own simulator to reproduce the result.

## Design notes
This is a combinational ALU, not a pipelined or clocked processor datapath. It does not include a register bank, instruction decoder, memory interface, or CPU integration. The carry flag is defined for addition only; subtraction carry/borrow semantics are not implemented.

## Future improvements
- Add subtraction borrow/carry convention if required by the target architecture.
- Add shift carry-out flags.
- Expand the testbench with randomized tests and exhaustive checks for selected operations.
- Run synthesis and inspect area/timing reports using an available FPGA/ASIC flow.
- Add assertions or a SystemVerilog verification environment.
