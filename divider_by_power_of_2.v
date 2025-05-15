`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2025 12:29:13 PM
// Design Name: 
// Module Name: divider_by_power_of_2
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


module divider_by_power_of_2 #(
    parameter SHIFT_AMOUNT = 2, // For division by 2^2 = 4
    parameter INPUT_WIDTH = 10, // Should be >= SUM_WIDTH from adder_tree
    parameter OUTPUT_WIDTH = INPUT_WIDTH - SHIFT_AMOUNT
) (
    input [INPUT_WIDTH-1:0] dividend,
    output reg [OUTPUT_WIDTH-1:0] quotient
);

    always @(*) begin
        quotient = dividend >> SHIFT_AMOUNT;
    end

endmodule
