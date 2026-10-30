`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2026 07:33:20 PM
// Design Name: 
// Module Name: sequential_multiplier
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


module sequential_multiplier (
    input clk,
    input rst,
    input start,
    input [3:0] A,       
    input [3:0] B,       
    output reg [7:0] product,
    output reg done
);

    localparam S_IDLE   = 2'b00;
    localparam S_ADD    = 2'b01;
    localparam S_SHIFT  = 2'b10;
    localparam S_DONE   = 2'b11;

    reg [1:0] state;
    reg [7:0] multiplicand;
    reg [3:0] multiplier;
    reg [7:0] running_sum;
    reg [2:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state        <= S_IDLE;
            product      <= 8'd0;
            running_sum  <= 8'd0;
            multiplicand <= 8'd0;
            multiplier   <= 4'd0;
            count        <= 3'd0;
            done         <= 1'b0;
        end else begin
            case (state)
                S_IDLE: begin
                    done <= 1'b0;
                    if (start) begin
                        multiplicand <= {4'b0000, A}; 
                        multiplier   <= B;
                        running_sum  <= 8'd0;
                        count        <= 3'd0;
                        state        <= S_ADD;
                    end
                end

                S_ADD: begin
                    if (multiplier[0] == 1'b1) begin
                        running_sum <= running_sum + multiplicand;
                    end
                    state <= S_SHIFT;
                end

                S_SHIFT: begin
                    multiplicand <= multiplicand << 1;
                    multiplier   <= multiplier >> 1;
                    count        <= count + 1'b1;
                    if (count == 3'd3) begin
                        state <= S_DONE;
                    end else begin
                        state <= S_ADD;
                    end
                end

                S_DONE: begin
                    product <= running_sum;
                    done    <= 1'b1;
                    if (!start) begin
                        state <= S_IDLE;
                    end
                end

                default: state <= S_IDLE;
            endcase
        end
    end

endmodule
