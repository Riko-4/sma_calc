`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2025 06:16:49 PM
// Design Name: 
// Module Name: data_buffer
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


module data_buffer #(
    parameter DATA_WIDTH = 8,
    parameter BUFFER_SIZE = 4
) (
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    input data_valid_in,
    output wire [DATA_WIDTH*BUFFER_SIZE - 1:0] data_out // Single multi-bit output
);

    reg [DATA_WIDTH-1:0] buffer [0:BUFFER_SIZE - 1]; // Internal buffer array
    integer i;

    // Shift buffer logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < BUFFER_SIZE; i = i + 1) begin
                buffer[i] <= 0;
            end
        end else if (data_valid_in) begin
            for (i = BUFFER_SIZE - 1; i > 0; i = i - 1) begin
                buffer[i] <= buffer[i-1];
            end
            buffer[0] <= data_in;
        end
    end

    // Convert buffer array to packed vector using generate block
    genvar idx;
    generate
        for (idx = 0; idx < BUFFER_SIZE; idx = idx + 1) begin : output_assign
            assign data_out[(DATA_WIDTH*(idx+1)) - 1 -: DATA_WIDTH] = buffer[idx];
        end
    endgenerate

endmodule

