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
    output wire [31:0] board7SD,    // FPGA board 7 segment display (4 digits) - for prices and change in $
    output wire boardChangeFive // $5 change LED
    );

integer priceA1 = 0;
integer priceA2 = 0;
integer priceA3 = 0;
integer priceB1 = 0;
integer priceB2 = 0;
integer priceB3 = 0;
integer priceC1 = 0;
integer priceC2 = 0;
integer priceC3 = 0;

integer totalMoney = 0;
integer change = 0;

// assign random prices, light up red LED on any OOS items
// need function to print value on FPGA given number in integer (?) format
// need function to return change in coins given change in integer (?) format

always @(A1 or A2 or A3 or B1 or B2 or B3 or C1 or C2 or C3) begin

    if (totalMoney == 0) begin // $ hasn't been inserted, so user is checking the price of the item
    
            if (A1) begin
            
                // display priceA1 on FPGA
            end
            
            else if (A2) begin
                    
                // display priceA2 on FPGA
            end
            
            else if (A3) begin
                            
                // display priceA3 on FPGA
            end
            
            else if (B1) begin
                                    
                // display priceB1 on FPGA
            end
            
            else if (B2) begin
                                            
                // display priceB2 on FPGA
            end
            
            else if (B3) begin
                                                    
                // display priceB3 on FPGA
            end
    
            else if (C1) begin
                                    
                // display priceC1 on FPGA
            end
            
            else if (C2) begin
                                            
                // display priceC2 on FPGA
            end
            
            else if (C3) begin
                                                    
                // display priceC3 on FPGA
            end
    end
    
    else if (totalMoney > 0) begin // $ has been inserted, and user is selecting item

        if (A1) begin
        
            change = totalMoney - priceA1;
            // display change on FPGA
        end
        
        else if (A2) begin
                
            change = totalMoney - priceA2;
            // display change on FPGA
        end
        
        else if (A3) begin
                        
            change = totalMoney - priceA3;
            // display change on FPGA
        end
        
        else if (B1) begin
                                
            change = totalMoney - priceB1;
            // display change on FPGA
        end
        
        else if (B2) begin
                                        
            change = totalMoney - priceB2;
            // display change on FPGA
        end
        
        else if (B3) begin
                                                
            change = totalMoney - priceB3;
            // display change on FPGA
        end

        else if (C1) begin
                                
            change = totalMoney - priceC1;
            // display change on FPGA
        end
        
        else if (C2) begin
                                        
            change = totalMoney - priceC2;
            // display change on FPGA
        end
        
        else if (C3) begin
                                                
            change = totalMoney - priceC3;
            // display change on FPGA
        end
        
        // return change in coins
        // reset
    end
end

always @(nickel or dime or quarter or fifty or dollar or five) begin

            if (nickel) begin
            
                totalMoney = totalMoney + 5;
            end
            
            else if (dime) begin

                totalMoney = totalMoney + 10;
            end
            
            else if (quarter) begin

                totalMoney = totalMoney + 25;
            end
            
            else if (fifty) begin

                totalMoney = totalMoney + 50;
            end
            
            else if (dollar) begin

                totalMoney = totalMoney + 100;
            end
            
            else if (five) begin

                totalMoney = totalMoney + 500;
            end
end

always @(cancelReset) begin

    if (change > 0) begin

        // return change in coins
        change = 0;
    end
    
    // reset
end

endmodule