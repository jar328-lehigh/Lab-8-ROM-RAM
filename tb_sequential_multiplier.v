`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2026 07:34:58 PM
// Design Name: 
// Module Name: tb_sequential_multiplier
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


module tb_sequential_multiplier;
    reg clk;
    reg rst;
    reg start;
    reg [3:0] A;
    reg [3:0] B;
    wire [7:0] product;
    wire done;

    sequential_multiplier uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .product(product),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        A = 0;
        B = 0;

        #20 rst = 0;

        //  6 * 3 = 18 
        #10 A = 4'd6; B = 4'd3; start = 1;
        #10 start = 0;
        wait(done == 1'b1);
        #10;
        $display("Test 1: %d * %d = %d (Expected: 18)", A, B, product);

        // 15 * 15 = 225
        #20 A = 4'd15; B = 4'd15; start = 1;
        #10 start = 0;
        wait(done == 1'b1);
        #10;
        $display("Test 2: %d * %d = %d (Expected: 225)", A, B, product);

        // 12 * 7 = 84
        #20 A = 4'd12; B = 4'd7; start = 1;
        #10 start = 0;
        wait(done == 1'b1);
        #10;
        $display("Test 3: %d * %d = %d (Expected: 84)", A, B, product);

        #50 $finish;
    end
endmodule
