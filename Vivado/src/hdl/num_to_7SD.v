`timescale 1ns / 1ps

module num_to_7SD(
    input wire [13:0] decNum, 
    input wire decimal,
    output wire [31:0] sevenSeg
    );

reg [13:0] number;
reg [3:0] thousands;
reg [3:0] hundreds;
reg [3:0] tens;
reg [3:0] ones;

reg [7:0] sseg;
reg [31:0] display;

assign sevenSeg = display;

always @(*) begin

    number = decNum;
    thousands = number / 1000;
    hundreds = (number - (thousands * 1000)) / 100;
    tens = (number - (thousands * 1000) - (hundreds * 100)) / 10;
    ones = (number - (thousands * 1000) - (hundreds * 100) - (tens * 10));
    
    case(ones)  // gfedcba
        4'b0000 : sseg = 8'b10000001;   // 0
        4'b0001 : sseg = 8'b11110011;   // 1
        4'b0010 : sseg = 8'b01001001;   // 2
        4'b0011 : sseg = 8'b01100001;   // 3
        4'b0100 : sseg = 8'b00110011;   // 4
        4'b0101 : sseg = 8'b00100101;   // 5
        4'b0110 : sseg = 8'b00000101;   // 6
        4'b0111 : sseg = 8'b11110001;   // 7
        4'b1000 : sseg = 8'b00000001;   // 8
        4'b1001 : sseg = 8'b00100001;   // 9
    endcase
    
    display = {display, sseg};
       
    case(tens)  // gfedcba
        4'b0000 : sseg = 8'b10000001;   // 0
        4'b0001 : sseg = 8'b11110011;   // 1
        4'b0010 : sseg = 8'b01001001;   // 2
        4'b0011 : sseg = 8'b01100001;   // 3
        4'b0100 : sseg = 8'b00110011;   // 4
        4'b0101 : sseg = 8'b00100101;   // 5
        4'b0110 : sseg = 8'b00000101;   // 6
        4'b0111 : sseg = 8'b11110001;   // 7
        4'b1000 : sseg = 8'b00000001;   // 8
        4'b1001 : sseg = 8'b00100001;   // 9
    endcase

    display = {display, sseg};
       
    case(hundreds)  // gfedcba
        4'b0000 : sseg = 8'b10000001;   // 0
        4'b0001 : sseg = 8'b11110011;   // 1
        4'b0010 : sseg = 8'b01001001;   // 2
        4'b0011 : sseg = 8'b01100001;   // 3
        4'b0100 : sseg = 8'b00110011;   // 4
        4'b0101 : sseg = 8'b00100101;   // 5
        4'b0110 : sseg = 8'b00000101;   // 6
        4'b0111 : sseg = 8'b11110001;   // 7
        4'b1000 : sseg = 8'b00000001;   // 8
        4'b1001 : sseg = 8'b00100001;   // 9
    endcase
    
    if (decimal == 1) begin
    
        sseg[0] = 1'b0;
    end
    
    display = {display, sseg};
    
    case(thousands)  // gfedcba
        4'b0000 : sseg = 8'b10000001;   // 0
        4'b0001 : sseg = 8'b11110011;   // 1
        4'b0010 : sseg = 8'b01001001;   // 2
        4'b0011 : sseg = 8'b01100001;   // 3
        4'b0100 : sseg = 8'b00110011;   // 4
        4'b0101 : sseg = 8'b00100101;   // 5
        4'b0110 : sseg = 8'b00000101;   // 6
        4'b0111 : sseg = 8'b11110001;   // 7
        4'b1000 : sseg = 8'b00000001;   // 8
        4'b1001 : sseg = 8'b00100001;   // 9
    endcase
    
    display = {display, sseg};
end

endmodule