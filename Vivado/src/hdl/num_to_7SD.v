`timescale 1ns / 1ps

module num_to_7SD(
    input wire [13:0] intNum, 
    input wire decimal,
    input wire negative,
    output wire [7:0] sSegAN0,
    output wire [7:0] sSegAN1,
    output wire [7:0] sSegAN2,
    output wire [7:0] sSegAN3
    );

reg [13:0] number;
reg [3:0] thousands;
reg [3:0] hundreds;
reg [3:0] tens;
reg [3:0] ones;

reg [7:0] sseg; // temporary

//reg [31:0] display;
reg [7:0] dispAN0;
reg [7:0] dispAN1;
reg [7:0] dispAN2;
reg [7:0] dispAN3;

assign sSegAN0 = dispAN0;
assign sSegAN1 = dispAN1;
assign sSegAN2 = dispAN2;
assign sSegAN3 = dispAN3;

always @(*) begin

    number = intNum;
    thousands = number / 1000;
    hundreds = (number - (thousands * 1000)) / 100;
    tens = (number - (thousands * 1000) - (hundreds * 100)) / 10;
    ones = (number - (thousands * 1000) - (hundreds * 100) - (tens * 10));
    
    case(thousands)  // gfedcba
        0 : sseg = 8'b10000001;   // 0
        1 : sseg = 8'b11110011;   // 1
        2 : sseg = 8'b01001001;   // 2
        3 : sseg = 8'b01100001;   // 3
        4 : sseg = 8'b00110011;   // 4
        5 : sseg = 8'b00100101;   // 5
        6 : sseg = 8'b00000101;   // 6
        7 : sseg = 8'b11110001;   // 7
        8 : sseg = 8'b00000001;   // 8
        9 : sseg = 8'b00100001;   // 9
    endcase
    
    if (negative) begin
    
        sseg = 8'b01111111;
    end
    
    //display = {display, sseg};
    dispAN3 = sseg;
    
    case(hundreds)  // gfedcba
        0 : sseg = 8'b10000001;   // 0
        1 : sseg = 8'b11110011;   // 1
        2 : sseg = 8'b01001001;   // 2
        3 : sseg = 8'b01100001;   // 3
        4 : sseg = 8'b00110011;   // 4
        5 : sseg = 8'b00100101;   // 5
        6 : sseg = 8'b00000101;   // 6
        7 : sseg = 8'b11110001;   // 7
        8 : sseg = 8'b00000001;   // 8
        9 : sseg = 8'b00100001;   // 9
    endcase
    
    if (decimal) begin
    
        sseg[0] = 1'b0;
    end
            
    //display = {display, sseg};
    dispAN2 = sseg;
                   
    case(tens)  // gfedcba
        0 : sseg = 8'b10000001;   // 0
        1 : sseg = 8'b11110011;   // 1
        2 : sseg = 8'b01001001;   // 2
        3 : sseg = 8'b01100001;   // 3
        4 : sseg = 8'b00110011;   // 4
        5 : sseg = 8'b00100101;   // 5
        6 : sseg = 8'b00000101;   // 6
        7 : sseg = 8'b11110001;   // 7
        8 : sseg = 8'b00000001;   // 8
        9 : sseg = 8'b00100001;   // 9
    endcase
    
    //display = {display, sseg};
    dispAN1 = sseg;
    
    case(ones)  // gfedcba
        0 : sseg = 8'b10000001;   // 0
        1 : sseg = 8'b11110011;   // 1
        2 : sseg = 8'b01001001;   // 2
        3 : sseg = 8'b01100001;   // 3
        4 : sseg = 8'b00110011;   // 4
        5 : sseg = 8'b00100101;   // 5
        6 : sseg = 8'b00000101;   // 6
        7 : sseg = 8'b11110001;   // 7
        8 : sseg = 8'b00000001;   // 8
        9 : sseg = 8'b00100001;   // 9
    endcase
    
    //display = {display, sseg};
    dispAN0 = sseg;
    
    if ((number == 0) && (decimal)) begin
    
        //display = 32'b01111111011111110111111101111111;
        dispAN0 = 8'b01111111;
        dispAN1 = 8'b01111111;
        dispAN2 = 8'b01111111;
        dispAN3 = 8'b01111111;
    end
    
    /*
    // DEBUG
    if (decimal) begin
    
        if (negative) begin
        
            $display("DEBUG: (num_to_7SD), display = -%0d.%0d%0d", hundreds, tens, ones);
        end
        
        else begin
        
            $display("DEBUG: (num_to_7SD), display = %0d%0d.%0d%0d", thousands, hundreds, tens, ones);
        end
    end
    
    if (decimal == 1'b0) begin
        $display("DEBUG: (num_to_7SD), display = %0d%0d%0d%0d", thousands, hundreds, tens, ones);
    end
    */
end

endmodule