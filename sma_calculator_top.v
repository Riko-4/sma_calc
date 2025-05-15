`timescale 1ns / 1ps
module sma_calculator_top #(
    parameter DATA_WIDTH = 8,
    parameter BUFFER_SIZE = 4
) (
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    input data_valid_in,
    output reg [DATA_WIDTH-1:0] sma_out,
    output reg [1:0] trade_signal_out
);

    // Calculate the width needed for the sum
    localparam SUM_WIDTH = $clog2(BUFFER_SIZE) + DATA_WIDTH;

    // Internal wires
    wire [DATA_WIDTH*BUFFER_SIZE - 1:0] buffered_data_vector; // Single vector from data_buffer
    wire [DATA_WIDTH-1:0] buffered_data [BUFFER_SIZE-1:0];     // Array to feed adder

    wire [SUM_WIDTH-1:0] sum_result;
    wire [DATA_WIDTH-1:0] sma_unreg; // Intermediate result before registering

    // Instantiate the data buffer
    data_buffer #(
        .DATA_WIDTH(DATA_WIDTH),
        .BUFFER_SIZE(BUFFER_SIZE)
    ) u_data_buffer (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_valid_in(data_valid_in),
        .data_out(buffered_data_vector)
    );

    // Extract individual buffered data values from the vector
    genvar k;
    generate
        for (k = 0; k < BUFFER_SIZE; k = k + 1) begin : unpack_vector
            assign buffered_data[k] = buffered_data_vector[(k+1)*DATA_WIDTH - 1 : k*DATA_WIDTH];
        end
    endgenerate

    // Instantiate the adder tree
    adder_tree #(
        .DATA_WIDTH(DATA_WIDTH),
        .BUFFER_SIZE(BUFFER_SIZE),
        .SUM_WIDTH(SUM_WIDTH)
    ) u_adder_tree (
        .data_in_vector(buffered_data_vector),
        .sum_out(sum_result)
    );

    // Instantiate the divider
    divider_by_power_of_2 #(
        .SHIFT_AMOUNT(2), // log2(BUFFER_SIZE)
        .INPUT_WIDTH(SUM_WIDTH),
        .OUTPUT_WIDTH(DATA_WIDTH)
    ) u_divider (
        .dividend(sum_result),
        .quotient(sma_unreg)
    );

    // Register the final SMA output
    always @(posedge clk or posedge rst) begin
        if (rst)
            sma_out <= 0;
        else
            sma_out <= sma_unreg;
    end

    // Instantiate the trading logic
    trading_logic #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_trading_logic (
        .clk(clk),
        .rst(rst),
        .current_price(data_in), // Assuming 'data_in' is the current price
        .sma(sma_out),
        .trade_signal(trade_signal_out)
    );

endmodule

