`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2026 07:55:31 PM
// Design Name: 
// Module Name: tb_combinational_multiplier
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


`timescale 1ns / 1ps

module tb_combinational_multiplier;
    reg  [3:0] a, b;
    wire [7:0] p;

    combinational_multiplier uut (
        .a(a),
        .b(b),
        .p(p)
    );

    integer i, j;

    initial begin
        a = 0;
        b = 0;
        #10;

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i;
                b = j;
                #5;
                if (p !== (a * b)) begin
                    $display("ERROR: %d * %d = %d (Expected: %d)", a, b, p, a * b);
                end
            end
        end

        $display("Combinational multiplier test completed successfully.");
        $finish;
    end
endmodule
