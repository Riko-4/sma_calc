`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2025 10:34:14 AM
// Design Name: 
// Module Name: adder_tree
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


module adder_tree #(
    parameter DATA_WIDTH = 8,
    parameter BUFFER_SIZE = 4,
    parameter SUM_WIDTH = $clog2(BUFFER_SIZE) + DATA_WIDTH
) (
    input [DATA_WIDTH*BUFFER_SIZE - 1:0] data_in_vector, // Single vector input
    output reg [SUM_WIDTH-1:0] sum_out
);

    wire [DATA_WIDTH-1:0] data_in [0:BUFFER_SIZE - 1]; // Unpacked wire array

    // Generate block to unpack the vector into an array of wires
    genvar idx;
    generate
        for (idx = 0; idx < BUFFER_SIZE; idx = idx + 1) begin : unpack_loop
            assign data_in[idx] = data_in_vector[(DATA_WIDTH*(idx+1)) - 1 -: DATA_WIDTH];
        end
    endgenerate

    integer i;
    reg [SUM_WIDTH-1:0] local_sum;

    always @(*) begin
        local_sum = 0;
        for (i = 0; i < BUFFER_SIZE; i = i + 1) begin
            local_sum = local_sum + data_in[i];
        end
        sum_out = local_sum;
    end

endmodule



