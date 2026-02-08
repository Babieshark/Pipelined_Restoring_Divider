# Pipelined Restoring Divider (Verilog)

## Problem Statement
Design and implement a parameterized **pipelined restoring division algorithm** in Verilog HDL that computes both **quotient and remainder** for unsigned division.  
The divider should support configurable datapath width and optional pipelining to balance latency and hardware complexity.

---

## Overview
This project implements a **32-bit pipelined restoring divider** using shift, compare, and subtract operations.  
The design allows selective pipelining of stages using a configurable `STAGE_LIST` parameter.

---

## Key Features
- Parameterized datapath width (`XLEN`)
- Configurable pipeline stages using `STAGE_LIST`
- Computes both **quotient and remainder**
- ACK-based completion signaling
- Modular RTL design

---

## Algorithm Description
The restoring division algorithm computes one quotient bit per iteration by:
1. Left-shifting the partial remainder
2. Comparing it with the divisor
3. Subtracting the divisor if possible
4. Appending the computed bit to the quotient

Pipelining is introduced at selected stages to improve throughput while keeping control logic simple.

---

## Verification
- Self-checking Verilog testbench
- Results verified against Verilog `/` and `%` operators
- Cycle-accurate validation using ACK signal

---

## Comparison with Other Division Algorithms
The restoring divider was analyzed and compared with:
- **SRT Division**
- **Newton–Raphson Division**
- **Goldschmidt Division**

in terms of latency, convergence, hardware complexity, and suitability for fixed-point and floating-point arithmetic.

---

## Directory Structure

- `rtl/divfunc.v` – Divider RTL
- `tb/tb_divfunc.v` – Testbench
- `docs/divider_report.pdf` – Detailed explanation and comparisons

## Tools
- Verilog HDL
- Simulated using standard event-driven simulators
