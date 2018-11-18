`timescale 1ns / 1ps

module num_to_7SD(
    input wire [13:0] decNum, 
    input wire decimal,
    output wire [31:0] display
    );

reg [13:0] number;
reg [3:0] thousands;
reg [3:0] hundreds;
reg [3:0] tens;
reg [3:0] ones;

always @(*) begin

    number = decNum;
    thousands = number / 1000;
    hundreds = (number - (thousands * 1000)) / 100;
    tens = (number - (thousands * 1000) - (hundreds * 100)) / 10;
    ones = (number - (thousands * 1000) - (hundreds * 100) - (tens * 10));
end

endmodule