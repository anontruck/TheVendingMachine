`timescale 1ns / 1ps

module vending(clock,reset,coin,A,B,C,vend,state,change);

input clock;
input reset;
input [5:0]coin; //assume largest to smallest value. 
input [2:0]A;
input [2:0]B;
input [2:0]C;
output [6:0]state;//we need to determine the number of states by making a state machine. 
output [5:0]change;
output [5:0] vend;

reg [6:0] state;//Total amount that has been inserted. 
reg [5:0] change;// change. one register for each of the six coins. 
reg [5:0] vend;//give them the product once payment and selection has been made. 

integer priceA1;//prices are all constants. 
integer priceA2;
integer priceA3;
integer priceB1;
integer priceB2;
integer priceB3;
integer priceC1;
integer priceC2;
integer priceC3;


initial //starting values. 
begin
state=0;
change=0;
vend=0;
end

always @(A,B,C) begin //Three always statements. One for price. One for change. One for vend.

    if (state == 0) begin // $ hasn't been inserted, so user is checking the price of the item
    
            if (A[0]==1)
             begin
            
                // display priceA1 on FPGA
               
            end
            
            else if (A[1]==1) 
             begin
                    
                // display priceA2 on FPGA

            end
            
            else if (A3) begin
                            
                // display priceA3 on FPGA
                A3 = 0;
            end
            
            else if (B1) begin
                                    
                // display priceB1 on FPGA
                B1 = 0;
            end
            
            else if (B2) begin
                                            
                // display priceB2 on FPGA
                B2 = 0;
            end
            
            else if (B3) begin
                                                    
                // display priceB3 on FPGA
                B3 = 0;
            end
    
            else if (C1) begin
                                    
                // display priceC1 on FPGA
                C1 = 0;
            end
            
            else if (C2) begin
                                            
                // display priceC2 on FPGA
                C2 = 0;
            end
            
            else if (C3) begin
                                                    
                // display priceC3 on FPGA
                C3 = 0;
            end
    end
    
    else if (state > 0) begin // $ has been inserted, and user is selecting item

        if (A1) begin
        
            // change = totalMoney - priceA1
            // display change on FPGA
        end
        
        else if (A2) begin
                
            // change = totalMoney - priceA2
            // display change on FPGA
        end
        
        else if (A3) begin
                        
            // change = totalMoney - priceA3
            // display change on FPGA
        end
        
        else if (B1) begin
                                
            // change = totalMoney - priceB1
            // display change on FPGA
        end
        
        else if (B2) begin
                                        
            // change = totalMoney - priceB2
            // display change on FPGA
        end
        
        else if (B3) begin
                                                
            // change = totalMoney - priceB3
            // display change on FPGA
        end

        else if (C1) begin
                                
            // change = totalMoney - priceC1
            // display change on FPGA
        end
        
        else if (C2) begin
                                        
            // change = totalMoney - priceC2
            // display change on FPGA
        end
        
        else if (C3) begin
                                                
            // change = totalMoney - priceC3
            // display change on FPGA
        end
        
        // return change in coins
    end
end

always @(nickel or dime or quarter or fifty or dollar or five) begin

            if (nickel) begin
            
                // increase totalMoney by 5
                nickel = 0;
            end
            
            else if (dime) begin
                    
                // increase totalMoney by 10
                dime = 0;
            end
            
            else if (quarter) begin
                            
                // increase totalMoney by 25
                quarter = 0;
            end
            
            else if (fifty) begin
                                    
                // increase totalMoney by 50
                fifty = 0;
            end
            
            else if (dollar) begin
                                            
                // increase totalMoney by 100
                dollar = 0;
            end
            
            else if (five) begin
                                                    
                // increase totalMoney by 500
                five = 0;
            end
end

always @(cancelReset) begin

    if (change > 0) begin

        if (nickel || dime || quarter || fifty || dollar || five) begin

            // return change
        end
    end
    
    // reset values
end

endmodule




endmodule
