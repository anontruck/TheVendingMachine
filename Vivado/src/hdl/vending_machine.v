`timescale 1ns / 1ps

module vending_machine(
    input wire A1_n,
    input wire A2_n,
    input wire A3_n,
    input wire B1_n,
    input wire B2_n,
    input wire B3_n,
    input wire C1_n,
    input wire C2_n,
    input wire C3_n,
    input wire nickel_n,
    input wire dime_n,
    input wire quarter_n,
    input wire fifty_n,
    input wire dollar_n,
    input wire five_n,
    input wire cancelReset_n,
    input wire coinsDisp_n,  // button to show current change in coins
    input wire clk,
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
    output wire [3:0] anx,   // selects which 7-seg to write to
    output wire [7:0] value
    );

reg [7:0] valx;
reg [3:0] en_an;

reg [7:0] dispAN0;// = 8'b10000001;    // LSB
reg [7:0] dispAN1;// = 8'b10000001;
reg [7:0] dispAN2;// = 8'b10000001;
reg [7:0] dispAN3;// = 8'b10000001;    // MSB

reg [8:0] priceA1;// = 100;
reg [8:0] priceA2;// = 0;
reg [8:0] priceA3;// = 125;
reg [8:0] priceB1;// = 175;
reg [8:0] priceB2;// = 225;
reg [8:0] priceB3;// = 250;
reg [8:0] priceC1;// = 100;
reg [8:0] priceC2;// = 325;
reg [8:0] priceC3;// = 375;

reg [8:0] maxMoney;// = 500;
reg [8:0] totalMoney;// = 0;
reg [8:0] change;// = 0;
reg [8:0] coins;// = 0;   // integer value showing each coin amount

reg [7:0] select;// = 8'h0;    // selected item code (A1, A2, A3, etc.)

initial begin

    dispAN0 = 8'b10000001;    // LSB
    dispAN1 = 8'b10000001;
    dispAN2 = 8'b10000001;
    dispAN3 = 8'b10000001;    // MSB

    priceA1 = 100;
    priceA2 = 0;
    priceA3 = 125;
    priceB1 = 175;
    priceB2 = 225;
    priceB3 = 250;
    priceC1 = 100;
    priceC2 = 325;
    priceC3 = 375;

    maxMoney = 500;
    totalMoney = 0;
    change = 0;
    coins = 0;   // integer value showing each coin amount

    select = 8'h0;    // selected item code (A1, A2, A3, etc.)
end

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

// temporary registers for instantiated modules
reg [13:0] num; // holds integer value to print (change or coins)
reg decimal;    // 1 or 0 depending on if a decimal should be shown (num_to_7SD)
reg negative;   // 1 or 0 depending on if a negative value will be shown (num_to_7SD)

wire [7:0] tmpDispAN0;  // LSB
wire [7:0] tmpDispAN1;
wire [7:0] tmpDispAN2;
wire [7:0] tmpDispAN3;  // MSB

wire [13:0] tmpCoins;   // holder for change in coins (num_to_coins); 14 bits for decimal 9999

num_to_7SD toDisp(.intNum(num), .decimal(decimal), .negative(negative), .sSegAN0(tmpDispAN0), .sSegAN1(tmpDispAN1), .sSegAN2(tmpDispAN2), .sSegAN3(tmpDispAN3));
num_to_coins toCoins(.intNum(num), .value(tmpCoins));

parameter N = 17;
reg [N+1:0] counter = 0;
wire [1:0] clkdiv;

always @(posedge clk) begin

    counter <= counter + 1;
end

assign clkdiv = counter[N+1:N];

always @(*) begin

    case(clkdiv)
        2'b00 : begin
            valx    <= dispAN0;
            en_an   <= 4'b1110;
        end
        2'b01 : begin
            valx    <= dispAN1;
            en_an   <= 4'b1101;
        end
        2'b10 : begin
            valx    <= dispAN2;
            en_an   <= 4'b1011;
        end
        2'b11 : begin
            valx    <= dispAN3;
            en_an   <= 4'b0111;
        end
    endcase
end

assign anx = en_an;
assign value = valx;

wire A1;
wire A2;
wire A3;
wire B1;
wire B2;
wire B3;
wire C1;
wire C2;
wire C3;
wire nickel;
wire dime;
wire quarter;
wire fifty;
wire dollar;
wire five;
wire cancelReset;
wire coinsDisp;

debounce swA1(.sig_out(A1), .button_n(A1_n), .clk_100_MHz(clk));
debounce swA2(.sig_out(A2), .button_n(A2_n), .clk_100_MHz(clk));
debounce swA3(.sig_out(A3), .button_n(A3_n), .clk_100_MHz(clk));
debounce swB1(.sig_out(B1), .button_n(B1_n), .clk_100_MHz(clk));
debounce swB2(.sig_out(B2), .button_n(B2_n), .clk_100_MHz(clk));
debounce swB3(.sig_out(B3), .button_n(B3_n), .clk_100_MHz(clk));
debounce swC1(.sig_out(C1), .button_n(C1_n), .clk_100_MHz(clk));
debounce swC2(.sig_out(C2), .button_n(C2_n), .clk_100_MHz(clk));
debounce swC3(.sig_out(C3), .button_n(C3_n), .clk_100_MHz(clk));
debounce nickelSW(.sig_out(nickel), .button_n(nickel_n), .clk_100_MHz(clk));
debounce dimeSW(.sig_out(dime), .button_n(dime_n), .clk_100_MHz(clk));
debounce quarterSW(.sig_out(quarter), .button_n(quarter_n), .clk_100_MHz(clk));
debounce fiftySW(.sig_out(fifty), .button_n(fifty_n), .clk_100_MHz(clk));
debounce dollarSW(.sig_out(dollar), .button_n(dollar_n), .clk_100_MHz(clk));
debounce fiveSW(.sig_out(five), .button_n(five_n), .clk_100_MHz(clk));
debounce cancelResetSW(.sig_out(cancelReset), .button_n(cancelReset_n), .clk_100_MHz(clk));
debounce coinsDispSW(.sig_out(coinsDisp), .button_n(coinsDisp_n), .clk_100_MHz(clk));

/*
// DEBUG: emulate 4x7SD
always @(dispAN0 or dispAN1 or dispAN2 or dispAN3) begin

    case(dispAN3)   // MSB; never has decimal
        8'b01111111 : $write("-");   // -
        8'b10000001 : $write("0");   // 0
        8'b11110011 : $write("1");   // 1
        8'b01001001 : $write("2");   // 2
        8'b01100001 : $write("3");   // 3
        8'b00110011 : $write("4");   // 4
        8'b00100101 : $write("5");   // 5
        8'b00000101 : $write("6");   // 6
        8'b11110001 : $write("7");   // 7
        8'b00000001 : $write("8");   // 8
        8'b00100001 : $write("9");   // 9
    endcase
    
    case(dispAN2)   // only one with decimal
        8'b01111111 : $write("-");   // -
        8'b10000001 : $write("0");   // 0, no decimal
        8'b11110011 : $write("1");   // 1
        8'b01001001 : $write("2");   // 2
        8'b01100001 : $write("3");   // 3
        8'b00110011 : $write("4");   // 4
        8'b00100101 : $write("5");   // 5
        8'b00000101 : $write("6");   // 6
        8'b11110001 : $write("7");   // 7
        8'b00000001 : $write("8");   // 8
        8'b00100001 : $write("9");   // 9
        8'b10000000 : $write("0.");   // 0, with decimal
        8'b11110010 : $write("1.");   // 1
        8'b01001000 : $write("2.");   // 2
        8'b01100000 : $write("3.");   // 3
        8'b00110010 : $write("4.");   // 4
        8'b00100100 : $write("5.");   // 5
        8'b00000100 : $write("6.");   // 6
        8'b11110000 : $write("7.");   // 7
        8'b00000000 : $write("8.");   // 8
        8'b00100000 : $write("9.");   // 9
    endcase
    
    case(dispAN1)   // never has decimal
        8'b01111111 : $write("-");   // -
        8'b10000001 : $write("0");   // 0
        8'b11110011 : $write("1");   // 1
        8'b01001001 : $write("2");   // 2
        8'b01100001 : $write("3");   // 3
        8'b00110011 : $write("4");   // 4
        8'b00100101 : $write("5");   // 5
        8'b00000101 : $write("6");   // 6
        8'b11110001 : $write("7");   // 7
        8'b00000001 : $write("8");   // 8
        8'b00100001 : $write("9");   // 9
    endcase
    
    case(dispAN0)   // LSB; never has decimal
        8'b01111111 : $write("-\n");   // -
        8'b10000001 : $write("0\n");   // 0
        8'b11110011 : $write("1\n");   // 1
        8'b01001001 : $write("2\n");   // 2
        8'b01100001 : $write("3\n");   // 3
        8'b00110011 : $write("4\n");   // 4
        8'b00100101 : $write("5\n");   // 5
        8'b00000101 : $write("6\n");   // 6
        8'b11110001 : $write("7\n");   // 7
        8'b00000001 : $write("8\n");   // 8
        8'b00100001 : $write("9\n");   // 9
    endcase
end
*/

always @(posedge A1 or posedge A2 or posedge A3 or posedge B1 or posedge B2 or posedge B3 or posedge C1 or posedge C2 or posedge C3 or posedge nickel or posedge dime or posedge quarter or posedge fifty or posedge dollar or posedge five or posedge cancelReset or negedge coinsDisp) begin

    if (A1 || A2 || A3 || B1 || B2 || B3 || C1 || C2 || C3 && (totalMoney == 0)) begin    // $ hasn't been inserted, so user is checking the price of the item
    
        decimal = 1;
        negative = 0;
    
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
                
        dispAN0 = tmpDispAN0;   // shows price or change on 7SD, depending on which value was assigned to num above
        dispAN1 = tmpDispAN1;
        dispAN2 = tmpDispAN2;
        dispAN3 = tmpDispAN3;
    end
        
    else if (A1 || A2 || A3 || B1 || B2 || B3 || C1 || C2 || C3 && (totalMoney > 0)) begin // $ has been inserted, and user is selecting item
    
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
    
            if (select != 8'h0) begin   // reset if selection was made successfully
            
                totalMoney = 0;
                change = 0;
                coins = 0;
            end
            
            dispAN0 = tmpDispAN0;   // shows price or change on 7SD, depending on which value was assigned to num above
                    dispAN1 = tmpDispAN1;
                    dispAN2 = tmpDispAN2;
                    dispAN3 = tmpDispAN3;
    
        end

    else if (nickel || dime || quarter || fifty || dollar || five) begin
    
        decimal = 1;
        negative = 0;
    
        if (nickel) begin
        
            if ((totalMoney + 5) > maxMoney) begin
                
                num = 5;    // loads tmpCoins with overflow change converted to proper coin on 7SD
                coins = coins + tmpCoins;
            end
            
            else begin
            
                totalMoney = totalMoney + 5;
                num = totalMoney;   // loads tmpDisp with total money inserted converted to 7SD format
                //#1; // DEBUG
                dispAN0 = tmpDispAN0;
                dispAN1 = tmpDispAN1;
                dispAN2 = tmpDispAN2;
                dispAN3 = tmpDispAN3;
            end
        end
                
        else if (dime) begin
    
            if ((totalMoney + 10) > maxMoney) begin
                    
                num = 10;
                coins = coins + tmpCoins;
            end
                    
            else begin
                    
                totalMoney = totalMoney + 10;
                num = totalMoney;
                //#1; // DEBUG
                dispAN0 = tmpDispAN0;
                dispAN1 = tmpDispAN1;
                dispAN2 = tmpDispAN2;
                dispAN3 = tmpDispAN3;
            end
        end
                
        else if (quarter) begin
    
            if ((totalMoney + 25) > maxMoney) begin
                    
                num = 25;
                coins = coins + tmpCoins;
            end
                    
            else begin
                    
                totalMoney = totalMoney + 25;
                num = totalMoney;
                //#1; // DEBUG
                dispAN0 = tmpDispAN0;
                dispAN1 = tmpDispAN1;
                dispAN2 = tmpDispAN2;
                dispAN3 = tmpDispAN3;
            end
        end
                
        else if (fifty) begin
    
            if ((totalMoney + 50) > maxMoney) begin
                    
                num = 50;
                coins = coins + tmpCoins;
            end
                    
            else begin
                    
                totalMoney = totalMoney + 50;
                num = totalMoney;
                //#1; // DEBUG
                dispAN0 = tmpDispAN0;
                dispAN1 = tmpDispAN1;
                dispAN2 = tmpDispAN2;
                dispAN3 = tmpDispAN3;
            end
        end
                
        else if (dollar) begin
    
            if ((totalMoney + 100) > maxMoney) begin
                    
                num = 100;
                coins = coins + tmpCoins;
            end
                    
            else begin
                    
                totalMoney = totalMoney + 100;
                num = totalMoney;
                //#1; // DEBUG
                dispAN0 = tmpDispAN0;
                dispAN1 = tmpDispAN1;
                dispAN2 = tmpDispAN2;
                dispAN3 = tmpDispAN3;
            end
        end
                
        else if (five) begin
    
            if ((totalMoney + 500) > maxMoney) begin
                    
                num = 500;
                coins = coins + tmpCoins;
            end
                    
            else begin
                    
                totalMoney = totalMoney + 500;
                num = totalMoney;
                //#1; // DEBUG
                dispAN0 = tmpDispAN0;
                dispAN1 = tmpDispAN1;
                dispAN2 = tmpDispAN2;
                dispAN3 = tmpDispAN3;
            end
        end
    end

    else if (cancelReset) begin
    
        decimal = 1;
        negative = 0;
    
        if (change > 0) begin
    
            num = change;   // loads tmpDisp with change in 7SD decimal format
        end
        
        else if (totalMoney > 0) begin
        
            num = totalMoney;   // loads tmpDisp with total money inserted in 7SD decimal format
        end

        totalMoney = 0; // reset
        change = 0;
        coins = 0;
        select = 8'h0;
        //#1;   // DEBUG
        dispAN0 = 8'b10000001;   // 0
        dispAN1 = 8'b10000001;   // 0
        dispAN2 = 8'b10000001;   // 0
        dispAN3 = 8'b10000001;   // 0
    end

    else if (coinsDisp == 1'b0) begin 
    
        decimal = 0;
        negative = 0;
        num = coins;    // loads tmpDisp with change in coins converted to 7SD format
        //#1; // DEBUG
        dispAN0 = tmpDispAN0;   // displays change in coins in 7SD format
        dispAN1 = tmpDispAN1;
        dispAN2 = tmpDispAN2;
        dispAN3 = tmpDispAN3;
    end

end

endmodule