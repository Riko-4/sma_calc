# FPGA-Based Simple Moving Average (SMA) Calculator

This repository contains Verilog code for a **Simple Moving Average (SMA) calculator**, designed to be implemented on an FPGA for use in **low-latency trading systems**. The project was developed using **Vivado** and demonstrates how a basic financial algorithm can be accelerated using hardware logic.

## What is SMA?

The **Simple Moving Average (SMA)** is a widely used technical indicator in financial markets. It calculates the average of a security’s price over a defined number of periods. Traders often use SMA to identify market trends, with **crossovers** between short-term and long-term SMAs generating buy/sell signals.

For example:
- If a short-term SMA (e.g., 5-period) crosses above a long-term SMA (e.g., 20-period), it can signal a **buy**.
- If it crosses below, it can indicate a **sell**.

## Why SMA on FPGA?

In **High-Frequency Trading (HFT)**, microseconds matter. Traditional software-based SMA calculations can become a bottleneck at scale. By implementing SMA directly on FPGA:
- Data can be processed **in parallel** and **in real time**.
- Latency is reduced significantly compared to software solutions.
- It enables **hardware-triggered decision logic** for trading systems.

This project demonstrates how a core trading algorithm like SMA can be adapted for **hardware acceleration** in finance applications.

## Contents

- `sma_calculator.v` – Verilog module to compute the moving average.
- `sma_tb.v` – Testbench for simulation and validation.
- `README.md` – Project description and overview.

## Future Work

- Extend to support multiple SMA periods (e.g., dual SMA crossover strategy).
- Integrate additional indicators like EMA or RSI.
- Develop full trading logic with buy/sell signal generation on FPGA.
- Optimize for specific FPGA platforms (e.g., Xilinx Artix-7).

## Tools Used

- Verilog HDL
- Vivado Design Suite
- ModelSim (for simulation)

I am still working on further integrating multiple other dynamic strategies together to improve the hit rate of the overall algorithm maintaining the lowest latency possible.  

## Contact

For questions, collaborations, or improvements, feel free to reach out or open an issue in the repository.

---

