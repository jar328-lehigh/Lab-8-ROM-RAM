`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2026 07:56:15 PM
// Design Name: 
// Module Name: top_combinational_mult
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


module top_combinational_mult (
    input clk,                   
    input [7:0] sw,              // sw[3:0] = a, sw[7:4] = b
    output [7:0] led,            // display 8-bit product
    output [3:0] an,             // 7-segment anodes
    output [6:0] seg             // 7-segment cathodes
);

    wire [7:0] product;

    combinational_multiplier u_comb_mult (
        .a(sw[3:0]),
        .b(sw[7:4]),
        .p(product)
    );

    assign led = product;

    reg [19:0] refresh_counter = 0;
    always @(posedge clk) refresh_counter <= refresh_counter + 1;

    wire [1:0] digit_sel = refresh_counter[19:18];
    reg [3:0] hex_digit;
    reg [3:0] an_reg;

    always @(*) begin
        case (digit_sel)
            2'b00: begin
                an_reg = 4'b1110;
                hex_digit = product[3:0];
            end
            2'b01: begin
                an_reg = 4'b1101;
                hex_digit = product[7:4];
            end
            default: begin
                an_reg = 4'b1111;
                hex_digit = 4'h0;
            end
        endcase
    end

    assign an = an_reg;

    reg [6:0] seg_reg;
    always @(*) begin
        case (hex_digit)
            4'h0: seg_reg = 7'b1000000;
            4'h1: seg_reg = 7'b1111001;
            4'h2: seg_reg = 7'b0100100;
            4'h3: seg_reg = 7'b0110000;
            4'h4: seg_reg = 7'b0011001;
            4'h5: seg_reg = 7'b0010010;
            4'h6: seg_reg = 7'b0000010;
            4'h7: seg_reg = 7'b1111000;
            4'h8: seg_reg = 7'b0000000;
            4'h9: seg_reg = 7'b0010000;
            4'hA: seg_reg = 7'b0001000;
            4'hB: seg_reg = 7'b0000011;
            4'hC: seg_reg = 7'b1000110;
            4'hD: seg_reg = 7'b0100001;
            4'hE: seg_reg = 7'b0000110;
            4'hF: seg_reg = 7'b0001110;
            default: seg_reg = 7'b1111111;
        endcase
    end
    assign seg = seg_reg;

endmodule
