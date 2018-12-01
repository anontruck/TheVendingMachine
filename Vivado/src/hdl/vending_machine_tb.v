//`include "vending_machine.v"

module vending_machine_tb();

reg A1;
reg A2;
reg A3;
reg B1;
reg B2;
reg B3;
reg C1;
reg C2;
reg C3;
reg nickel;
reg dime;
reg quarter;
reg fifty;
reg dollar;
reg five;
reg cancelReset;
reg coinsDisp;

wire gLEDA1;
wire rLEDA1;
wire gLEDA2;
wire rLEDA2;
wire gLEDA3;
wire rLEDA3;
wire gLEDB1;
wire rLEDB1;
wire gLEDB2;
wire rLEDB2;
wire gLEDB3;
wire rLEDB3;
wire gLEDC1;
wire rLEDC1;
wire gLEDC2;
wire rLEDC2;
wire gLEDC3;
wire rLEDC3;
wire [31:0] board7SD;

vending_machine #(0) machine(
    .A1(A1),
    .A2(A2),
    .A3(A3),
    .B1(B1),
    .B2(B2),
    .B3(B3),
    .C1(C1),
    .C2(C2),
    .C3(C3),
    .nickel(nickel),
    .dime(dime),
    .quarter(quarter),
    .fifty(fifty),
    .dollar(dollar),
    .five(five),
    .cancelReset(cancelReset),
    .coinsDisp(coinsDisp),
    .gLEDA1(gLEDA1),
    .rLEDA1(rLEDA1),
    .gLEDA2(gLEDA2),
    .rLEDA2(rLEDA2),
    .gLEDA3(gLEDA3),
    .rLEDA3(rLEDA3),
    .gLEDB1(gLEDB1),
    .rLEDB1(rLEDB1),
    .gLEDB2(gLEDB2),
    .rLEDB2(rLEDB2),
    .gLEDB3(gLEDB3),
    .rLEDB3(rLEDB3),
    .gLEDC1(gLEDC1),
    .rLEDC1(rLEDC1),
    .gLEDC2(gLEDC2),
    .rLEDC2(rLEDC2),
    .gLEDC3(gLEDC3),
    .rLEDC3(rLEDC3),
    .board7SD(board7SD)
    );

initial begin
    //$dumpfile("out.vcd");
    //$dumpvars(0, machine);

    $monitor("time = %0d, board7SD = %0b", $time, board7SD);
    #1 A1 = 1;
    #1 A1 = 0;
    
    #1 A2 = 1;
    #1 A2 = 0;
    
    #1 B2 = 1;
    #1 B2 = 0;
    
    #1 C3 = 1;
    #1 C3 = 0;
    
    #1 dollar = 1;
    #1 dollar = 0;
    
    #1 dollar = 1;
    #1 dollar = 0;
    
    #1 dollar = 1;
    #1 dollar = 0;
    
    #1 dollar = 1;
    #1 dollar = 0;
    
    #1 dollar = 1;
    #1 dollar = 0;
    
    #1 quarter = 1;
    #1 quarter = 0;
    
    #1 coinsDisp = 1;
    #1 coinsDisp = 0;

    #1 A1 = 1;
    #1 A1 = 0;

    #1 cancelReset = 1;
    #1 cancelReset = 0;
    
    #1 coinsDisp = 1;
    #1 coinsDisp = 0;
    
    #1000 $finish;
end
    
endmodule