`timescale 1ns / 1ps

module vending_machine(
    input wire A1,
    input wire A2,
    input wire A3,
    input wire B1,
    input wire B2,
    input wire B3,
    input wire C1,
    input wire C2,
    input wire C3,
    input wire nickel,
    input wire dime,
    input wire quarter,
    input wire fifty,
    input wire dollar,
    input wire five,
    input wire cancelReset,
    output wire gLEDA1, // green LED for A1 - means inserted $ >= A1 price
    output wire rLEDA1, // red LED A1 - means A1 is OOS
    output wire gLEDA2,
    output wire rLEDA2,
    output wire gLEDA3,
    output wire rLEDA3,
    output wire gLEDB1,
    output wire rLEDB1,
    output wire gLEDB2,
    output wire rLEDB2,
    output wire gLEDB3,
    output wire rLEDB3,
    output wire gLEDC1,
    output wire rLEDC1,
    output wire gLEDC2,
    output wire rLEDC2,
    output wire gLEDC3,
    output wire rLEDC3,
    output wire [27:0] board7SD,    // FPGA board 7 segment display (4 digits) - for prices and change in $
    output wire [27:0] boardChange, // FPGA board 7 segment display (4 digits) - for coin return (dollar, quarter, dime, nickel)
    output wire boardChangeFive // $5 change LED
    );

reg priceA1;
reg priceA2;
reg priceA3;
reg priceB1;
reg priceB2;
reg priceB3;
reg priceC1;
reg priceC2;
reg priceC3;

always @(*) begin

    // Assign random prices, light up red LED on any OOS items
end

always @(posedge A1 or posedge A2 or posedge A3 or posedge B1 or posedge B2 or posedge B3 or posedge C1 or posedge C2 or posedge C3) begin

    // if $ has been inserted, user is selecting item
    // if $ hasn't been inserted, user is checking the price of the item
end

always @(posedge nickel or posedge dime or posedge quarter or posedge fifty or posedge dollar or posedge five) begin

    // add $ to total of money inserted
end

always @(posedge cancelReset) begin

    if (nickel || dime || quarter || fifty || dollar || five) begin
        // return change
    end
    
    // reset values
end

endmodule