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
    input wire coinsDisp,  // button to show current change in coins
    output wire gLEDA1, // green LED for A1 - means inserted $ >= A1 price
    output wire rLEDA1, // red LED for A1 - means A1 is OOS
    output wire dLEDA1, // board LED for A1 - means A1 has been dispensed
    output wire gLEDA2,
    output wire rLEDA2,
    output wire dLEDA2,
    output wire gLEDA3,
    output wire rLEDA3,
    output wire dLEDA3,
    output wire gLEDB1,
    output wire rLEDB1,
    output wire dLEDB1,
    output wire gLEDB2,
    output wire rLEDB2,
    output wire dLEDB2,
    output wire gLEDB3,
    output wire rLEDB3,
    output wire dLEDB3,
    output wire gLEDC1,
    output wire rLEDC1,
    output wire dLEDC1,
    output wire gLEDC2,
    output wire rLEDC2,
    output wire dLEDC2,
    output wire gLEDC3,
    output wire rLEDC3,
    output wire dLEDC3,
    output wire [31:0] board7SD    // FPGA board 7 segment display (4 digits) - for prices and change in $
    );

reg [31:0] display;
assign board7SD = display;

reg [8:0] priceA1 = 100;
reg [8:0] priceA2 = 0;
reg [8:0] priceA3 = 125;
reg [8:0] priceB1 = 175;
reg [8:0] priceB2 = 225;
reg [8:0] priceB3 = 250;
reg [8:0] priceC1 = 100;
reg [8:0] priceC2 = 325;
reg [8:0] priceC3 = 375;

reg [8:0] maxMoney = 500;
reg [8:0] totalMoney = 0;
reg [8:0] change;
//reg [8:0] coins;   // integer value showing each coin amount

reg [7:0] select = 8'hx;    // selected item code (A1, A2, A3, etc.)

assign gLEDA1 = ((totalMoney >= priceA1) && (priceA1 != 0)) ? 1'b1 : 1'b0;
assign gLEDA2 = ((totalMoney >= priceA2) && (priceA2 != 0)) ? 1'b1 : 1'b0;
assign gLEDA3 = ((totalMoney >= priceA3) && (priceA3 != 0)) ? 1'b1 : 1'b0;
assign gLEDB1 = ((totalMoney >= priceB1) && (priceB1 != 0)) ? 1'b1 : 1'b0;
assign gLEDB2 = ((totalMoney >= priceB2) && (priceB2 != 0)) ? 1'b1 : 1'b0;
assign gLEDB3 = ((totalMoney >= priceB3) && (priceB3 != 0)) ? 1'b1 : 1'b0;
assign gLEDC1 = ((totalMoney >= priceC1) && (priceC1 != 0)) ? 1'b1 : 1'b0;
assign gLEDC2 = ((totalMoney >= priceC2) && (priceC2 != 0)) ? 1'b1 : 1'b0;
assign gLEDC3 = ((totalMoney >= priceC3) && (priceC3 != 0)) ? 1'b1 : 1'b0;

assign rLEDA1 = (priceA1 == 0) ? 1'b1 : 1'b0;
assign rLEDA2 = (priceA2 == 0) ? 1'b1 : 1'b0;
assign rLEDA3 = (priceA3 == 0) ? 1'b1 : 1'b0;
assign rLEDB1 = (priceB1 == 0) ? 1'b1 : 1'b0;
assign rLEDB2 = (priceB2 == 0) ? 1'b1 : 1'b0;
assign rLEDB3 = (priceB3 == 0) ? 1'b1 : 1'b0;
assign rLEDC1 = (priceC1 == 0) ? 1'b1 : 1'b0;
assign rLEDC2 = (priceC2 == 0) ? 1'b1 : 1'b0;
assign rLEDC3 = (priceC3 == 0) ? 1'b1 : 1'b0;

assign dLEDA1 = (select == 8'ha1) ? 1'b1 : 1'b0;   // LED indicates item has been dispensed
assign dLEDA2 = (select == 8'ha2) ? 1'b1 : 1'b0;
assign dLEDA3 = (select == 8'ha3) ? 1'b1 : 1'b0;
assign dLEDB1 = (select == 8'hb1) ? 1'b1 : 1'b0;
assign dLEDB2 = (select == 8'hb2) ? 1'b1 : 1'b0;
assign dLEDB3 = (select == 8'hb3) ? 1'b1 : 1'b0;
assign dLEDC1 = (select == 8'hc1) ? 1'b1 : 1'b0;
assign dLEDC2 = (select == 8'hc2) ? 1'b1 : 1'b0;
assign dLEDC3 = (select == 8'hc3) ? 1'b1 : 1'b0;

reg [31:0] coinsDispTmp;    // to hold 7SD value when pressing coinsDisp

// temporary registers for instantiated modules
reg [13:0] num; // holds integer value to print (change or coins)
reg decimal;    // 1 or 0 depending on if a decimal should be shown (num_to_7SD)
reg negative;   // 1 or 0 depending on if a negative value will be shown (num_to_7SD)
wire [31:0] tmpDisp; // holder for output before printing (num_to_7SD)
wire [13:0] tmpCoins; // holder for change in coins (num_to_coins)

num_to_7SD toDisp(.intNum(num), .decimal(decimal), .negative(negative), .sevenSeg(tmpDisp));
num_to_coins toCoins(.intNum(num), .value(tmpCoins));

always @(posedge A1 or posedge A2 or posedge A3 or posedge B1 or posedge B2 or posedge B3 or posedge C1 or posedge C2 or posedge C3) begin

    decimal = 1;
    negative = 0;

    if (totalMoney == 0) begin // $ hasn't been inserted, so user is checking the price of the item
    
            if (A1) begin
            
                num = priceA1;  // loads tmpDisp with priceA1; will print when display = tmpDisp
            end
            
            else if (A2) begin
                    
                num = priceA2;
            end
            
            else if (A3) begin
                            
                num = priceA3;
            end
            
            else if (B1) begin
                                    
                num = priceB1;
            end
            
            else if (B2) begin
                                            
                num = priceB2;
            end
            
            else if (B3) begin
                                                    
                num = priceB3;
            end
    
            else if (C1) begin
                                    
                num = priceC1;
            end
            
            else if (C2) begin
                                            
                num = priceC2;
            end
            
            else if (C3) begin
                                                    
                num = priceC3;
            end
    end
    
    else if (totalMoney > 0) begin // $ has been inserted, and user is selecting item

        if (A1) begin
        
            if ((totalMoney >= priceA1) && (priceA1 != 1'b0)) begin
            
                change = totalMoney - priceA1;
                num = change;   // loads tmpDisp with change; will print when display = tmpDisp
                select = 8'ha1;
            end
            
            else begin
            
                negative = 1;
                num = priceA1 - totalMoney; // loads tmpDisp with required change; will print when display = tmpDisp
            end
        end
        
        else if (A2) begin
                
            if ((totalMoney >= priceA2) && (priceA2 != 1'b0)) begin
            
                change = totalMoney - priceA2;
                num = change;
                select = 8'ha2;
            end
                    
            else begin
                    
                negative = 1;
                num = priceA2 - totalMoney;
            end
        end
        
        else if (A3) begin
                        
            if ((totalMoney >= priceA3) && (priceA3 != 1'b0)) begin
        
                change = totalMoney - priceA3;
                num = change;
                select = 8'ha3;
            end
        
            else begin
        
                negative = 1;
                num = priceA3 - totalMoney;
            end
        end
        
        else if (B1) begin
                                
            if ((totalMoney >= priceB1) && (priceB1 != 1'b0)) begin
        
                change = totalMoney - priceB1;
                num = change;
                select = 8'hb1;
            end
        
            else begin
        
                negative = 1;
                num = priceB1 - totalMoney;
            end
        end
        
        else if (B2) begin
                                        
            if ((totalMoney >= priceB2) && (priceB2 != 1'b0)) begin
        
                change = totalMoney - priceB2;
                num = change;
                select = 8'hb2;
            end
        
            else begin
        
                negative = 1;
                num = priceB2 - totalMoney;
            end
        end
        
        else if (B3) begin
                                                
            if ((totalMoney >= priceB3) && (priceB3 != 1'b0)) begin
        
                change = totalMoney - priceB3;
                num = change;
                select = 8'hb3;
            end
        
            else begin
        
                negative = 1;
                num = priceB3 - totalMoney;
            end
        end

        else if (C1) begin
                                
            if ((totalMoney >= priceC1) && (priceC1 != 1'b0)) begin
        
                change = totalMoney - priceC1;
                num = change;
                select = 8'hc1;
            end
        
            else begin
        
                negative = 1;
                num = priceC1 - totalMoney;
            end
        end
        
        else if (C2) begin
                                        
            if ((totalMoney >= priceC2) && (priceC2 != 1'b0)) begin
        
                change = totalMoney - priceC2;
                num = change;
                select = 8'hc2;
            end
        
            else begin
        
                negative = 1;
                num = priceC2 - totalMoney;
            end
        end
        
        else if (C3) begin
                                                
            if ((totalMoney >= priceC3) && (priceC3 != 1'b0)) begin
        
                change = totalMoney - priceC3;
                num = change;
                select = 8'hc3;
            end
        
            else begin
        
                negative = 1;
                num = priceC3 - totalMoney;
            end
        end

        totalMoney = 0;
        change = 0;
        //coins = 0;
    end

    display = tmpDisp;  // shows price or change on 7SD, depending on which value was assigned to num above
end

always @(posedge nickel or posedge dime or posedge quarter or posedge fifty or posedge dollar or posedge five) begin

    decimal = 1;
    negative = 0;

    if (nickel) begin
    
        if ((totalMoney + 5) > maxMoney) begin
            
            num = 5;    // loads tmpCoins with overflow change converted to proper coin on 7SD
        end
        
        else begin
        
            totalMoney = totalMoney + 5;
            num = totalMoney;
        end
    end
            
    else if (dime) begin

        if ((totalMoney + 10) > maxMoney) begin
                
            num = 10;
        end
                
        else begin
                
            totalMoney = totalMoney + 10;
            num = totalMoney;
        end
    end
            
    else if (quarter) begin

        if ((totalMoney + 25) > maxMoney) begin
                
            num = 25;
        end
                
        else begin
                
            totalMoney = totalMoney + 25;
            num = totalMoney;
        end
    end
            
    else if (fifty) begin

        if ((totalMoney + 50) > maxMoney) begin
                
            num = 50;
        end
                
        else begin
                
            totalMoney = totalMoney + 50;
            num = totalMoney;
        end
    end
            
    else if (dollar) begin

        if ((totalMoney + 100) > maxMoney) begin
                
            num = 100;
        end
                
        else begin
                
            totalMoney = totalMoney + 100;
            num = totalMoney;
        end
    end
            
    else if (five) begin

        if ((totalMoney + 500) > maxMoney) begin
                
            num = 500;
        end
                
        else begin
                
            totalMoney = totalMoney + 500;
            num = totalMoney;
        end
    end
    
    //coins = coins + tmpCoins;   // adds overflow change to total change in coins; will display when display = coins
    display = num;
end

always @(posedge cancelReset) begin

    if (change > 0) begin

        num = change;   // loads tmpDisp with change in 7SD decimal format
    end
    
    else if (totalMoney > 0) begin
    
        num = totalMoney;   // loads tmpDisp with total money inserted in 7SD decimal format
    end
    
    totalMoney = 0;
    change = 0;
    //coins = 0;
    select = 8'hx;
    display = tmpDisp;  // print change on 7SD
end

always @(posedge coinsDisp) begin

    decimal = 0;
    coinsDispTmp = display; // save current 7SD to restore on negedge button press
    num = tmpCoins; // loads tmpDisp with change in coins converted to 7SD format
    display = tmpDisp;  // displays change in coins in 7SD format
    //$display("DEBUG (vending_machine), posedge coinsDisp");
end

always @(negedge coinsDisp) begin

    display = coinsDispTmp; // restore previously saved 7SD value
    //$display("DEBUG (vending_machine), negedge coinsDisp");
end

endmodule