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
    output wire coinsDisplay,	// button to show current change in coins
    output wire [31:0] board7SD    // FPGA board 7 segment display (4 digits) - for prices and change in $
    );

assign gLEDA1 = ((totalMoney >= priceA1) && (priceA1 != 0)) ? 1'b1 : 1'b0;
assign gLEDA2 = ((totalMoney >= priceA2) && (priceA2 != 0)) ? 1'b1 : 1'b0;
assign gLEDA3 = ((totalMoney >= priceA3) && (priceA3 != 0)) ? 1'b1 : 1'b0;
assign gLEDB1 = ((totalMoney >= priceB1) && (priceB1 != 0)) ? 1'b1 : 1'b0;
assign gLEDB2 = ((totalMoney >= priceB2) && (priceB2 != 0)) ? 1'b1 : 1'b0;
assign gLEDB3 = ((totalMoney >= priceB3) && (priceB3 != 0)) ? 1'b1 : 1'b0;
assign gLEDC1 = ((totalMoney >= priceC1) && (priceC1 != 0)) ? 1'b1 : 1'b0;
assign gLEDC2 = ((totalMoney >= priceC2) && (priceC2 != 0)) ? 1'b1 : 1'b0;
assign gLEDC3 = ((totalMoney >= priceC3) && (priceC3 != 0)) ? 1'b1 : 1'b0;

assign rLEDA1 = (priceA1 == 0) ? 1'b1 : 1'b0;   // need to OOS value = 0
assign rLEDA2 = (priceA2 == 0) ? 1'b1 : 1'b0;
assign rLEDA3 = (priceA3 == 0) ? 1'b1 : 1'b0;
assign rLEDB1 = (priceB1 == 0) ? 1'b1 : 1'b0;
assign rLEDB2 = (priceB2 == 0) ? 1'b1 : 1'b0;
assign rLEDB3 = (priceB3 == 0) ? 1'b1 : 1'b0;
assign rLEDC1 = (priceC1 == 0) ? 1'b1 : 1'b0;
assign rLEDC2 = (priceC2 == 0) ? 1'b1 : 1'b0;
assign rLEDC3 = (priceC3 == 0) ? 1'b1 : 1'b0;

reg [31:0] display;
assign board7SD = display;

reg [8:0] priceA1 = 100;    // 9 bits to hold up to binary 500, minus the sign bit
reg [8:0] priceA2 = 0;      // might not be proper assignment here (outside always block)
reg [8:0] priceA3 = 125;
reg [8:0] priceB1 = 175;
reg [8:0] priceB2 = 225;
reg [8:0] priceB3 = 250;
reg [8:0] priceC1 = 100;
reg [8:0] priceC2 = 325;
reg [8:0] priceC3 = 375;

reg [8:0] maxMoney;
reg [8:0] totalMoney;
reg [8:0] change;
reg [13:0] coins;   // integer value showing each coin amount

reg [31:0] tempDisp;    // to hold 7SD value when pressing coinsDisplay

num_to_7SD toDisp(.intNum(int), .decimal(decimal), .sevenSeg(display));
num_to_coins toCoins(.intNum(int), .value(coins));

// temporary registers for instantiated modules
reg [13:0] int; // holds integer value to print (change or coins)
reg decimal;    // 1 or 0 depending on if a decimal should be shown (num_to_7SD)

always @(posedge A1 or posedge A2 or posedge A3 or posedge B1 or posedge B2 or posedge B3 or posedge C1 or posedge C2 or posedge C3) begin

    if (totalMoney == 0) begin // $ hasn't been inserted, so user is checking the price of the item

            decimal = 1;
    
            if (A1) begin
            
                // display priceA1 on FPGA; num_to_7SD.v, decimal = 1
                int = priceA1;
            end
            
            else if (A2) begin
                    
                // display priceA2 on FPGA; num_to_7SD.v, decimal = 1
                int = priceA2;
            end
            
            else if (A3) begin
                            
                // display priceA3 on FPGA; num_to_7SD.v, decimal = 1
                int = priceA3;
            end
            
            else if (B1) begin
                                    
                // display priceB1 on FPGA; num_to_7SD.v, decimal = 1
                int = priceB1;
            end
            
            else if (B2) begin
                                            
                // display priceB2 on FPGA; num_to_7SD.v, decimal = 1
                int = priceB2;
            end
            
            else if (B3) begin
                                                    
                // display priceB3 on FPGA; num_to_7SD.v, decimal = 1
                int = priceB3;
            end
    
            else if (C1) begin
                                    
                // display priceC1 on FPGA; num_to_7SD.v, decimal = 1
                int = priceC1;
            end
            
            else if (C2) begin
                                            
                // display priceC2 on FPGA; num_to_7SD.v, decimal = 1
                int = priceC2;
            end
            
            else if (C3) begin
                                                    
                // display priceC3 on FPGA; num_to_7SD.v, decimal = 1
                int = priceC3;
            end
    end
    
    else if (totalMoney > 0) begin // $ has been inserted, and user is selecting item

        decimal = 1;

        if (A1) begin
        
            if (totalMoney >= priceA1) begin
            
                // display change on FPGA; num_to_7SD.v, decimal = 1
                change = totalMoney - priceA1;
		int = change;
            end
            
            else begin
            
                // ? What to do if user selects an item without enough money inserted?
            end
        end
        
        else if (A2) begin
                
            if (totalMoney >= priceA2) begin
            
                // display change on FPGA; num_to_7SD.v, decimal = 1
                change = totalMoney - priceA2;
                int = change;
            end
                    
            else begin
                    
                // ? What to do if user selects an item without enough money inserted?
            end
        end
        
        else if (A3) begin
                        
            if (totalMoney >= priceA3) begin
        
                // display change on FPGA; num_to_7SD.v, decimal = 1
                change = totalMoney - priceA3;
                int = change;
            end
        
            else begin
        
                // ? What to do if user selects an item without enough money inserted?
            end
        end
        
        else if (B1) begin
                                
            if (totalMoney >= priceB1) begin
        
                // display change on FPGA; num_to_7SD.v, decimal = 1
                change = totalMoney - priceB1;
                int = change;
            end
        
            else begin
        
                // ? What to do if user selects an item without enough money inserted?
            end
        end
        
        else if (B2) begin
                                        
            if (totalMoney >= priceB2) begin
        
                // display change on FPGA; num_to_7SD.v, decimal = 1
                change = totalMoney - priceB2;
                int = change;
            end
        
            else begin
        
                // ? What to do if user selects an item without enough money inserted?
            end
        end
        
        else if (B3) begin
                                                
            if (totalMoney >= priceB3) begin
        
                // display change on FPGA; num_to_7SD.v, decimal = 1
                change = totalMoney - priceB3;
                int = change;
            end
        
            else begin
        
                // ? What to do if user selects an item without enough money inserted?
            end
        end

        else if (C1) begin
                                
            if (totalMoney >= priceC1) begin
        
                // display change on FPGA; num_to_7SD.v, decimal = 1
                change = totalMoney - priceC1;
                int = change;
            end
        
            else begin
        
                // ? What to do if user selects an item without enough money inserted?
            end
        end
        
        else if (C2) begin
                                        
            if (totalMoney >= priceC2) begin
        
                // display change on FPGA; num_to_7SD.v, decimal = 1
                change = totalMoney - priceC2;
                int = change;
            end
        
            else begin
        
                // ? What to do if user selects an item without enough money inserted?
            end
        end
        
        else if (C3) begin
                                                
            if (totalMoney >= priceC3) begin
        
                // display change on FPGA; num_to_7SD.v, decimal = 1
                change = totalMoney - priceC3;
                int = change;
            end
        
            else begin
        
                // ? What to do if user selects an item without enough money inserted?
            end
        end
        
        // return change in coins; num_to_coins.v -> num_to_7SD.v
        totalMoney = 0;
    end
end

always @(posedge nickel or posedge dime or posedge quarter or posedge fifty or posedge dollar or posedge five) begin

    decimal = 1;

    if (nickel) begin
    
        if ((totalMoney + 5) > maxMoney) begin
            
            // return nickel; num_to_coins.v -> num_to_7SD.v
        end
        
        else begin
        
            totalMoney = totalMoney + 5;
        end
    end
            
    else if (dime) begin

        if ((totalMoney + 10) > maxMoney) begin
                
            // return dime; num_to_coins.v -> num_to_7SD.v
        end
                
        else begin
                
            totalMoney = totalMoney + 10;
        end
    end
            
    else if (quarter) begin

        if ((totalMoney + 25) > maxMoney) begin
                
            // return quarter; num_to_coins.v -> num_to_7SD.v
        end
                
        else begin
                
            totalMoney = totalMoney + 25;
        end
    end
            
    else if (fifty) begin

        if ((totalMoney + 50) > maxMoney) begin
                
            // return 2 x quarters; num_to_coins.v -> num_to_7SD.v
        end
                
        else begin
                
            totalMoney = totalMoney + 50;
        end
    end
            
    else if (dollar) begin

        if ((totalMoney + 100) > maxMoney) begin
                
            // return dollar; num_to_coins.v -> num_to_7SD.v
        end
                
        else begin
                
            totalMoney = totalMoney + 100;
        end
    end
            
    else if (five) begin

        if ((totalMoney + 500) > maxMoney) begin
                
            // return 5 x dollar bills; num_to_coins.v -> num_to_7SD.v
        end
                
        else begin
                
            totalMoney = totalMoney + 500;
        end
    end
end

always @(posedge cancelReset) begin

    if (change > 0) begin

        // return change in coins; num_to_coins.v -> num_to_7SD.v
    end
    
    totalMoney = 0;
end

always @(posedge coinsDisplay) begin

    decimal = 0;

    tempDisp = display;
    // show change in coins on FPGA; num_to_coins.v -> num_to_7SD.v
end

always @(negedge coinsDisplay) begin

    display = tempDisp;
    // might need some debounce code
end

endmodule