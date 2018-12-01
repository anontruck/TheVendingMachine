`timescale 1ns / 1ps

module num_to_coins(
    input wire [13:0] intNum,
    output wire [13:0] value
    );

reg [13:0] number;
reg [3:0] dollars;
reg [3:0] quarters;
reg [3:0] dimes;
reg [3:0] nickels;
reg [13:0] coins;

assign value = coins;

always @(*) begin

    number = intNum;
    
    dollars = number / 100;
    quarters = (number - (dollars * 100)) / 25;
    dimes = (number - (dollars * 100) - (quarters * 25)) / 10;
    nickels = (number - (dollars * 100) - (quarters * 25) - (dimes * 10)) / 5;
    
    coins = (dollars * 1000) + (quarters * 100) + (dimes * 10) + nickels;
end

endmodule