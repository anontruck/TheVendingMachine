
`include "../hdl/vending_machine.v"
`include "../hdl/num_to_7SD.v"
`include "../hdl/num_to_coins.v"
`include "../hdl/debounce.v"


module vending_machine_tb();

reg A1_n;
reg A2_n;
reg A3_n;
reg B1_n;
reg B2_n;
reg B3_n;
reg C1_n;
reg C2_n;
reg C3_n;
reg nickel_n;
reg dime_n;
reg quarter_n;
reg fifty_n;
reg dollar_n;
reg five_n;
reg cancelReset_n;
reg coinsDisp_n = 1;
reg clk;

wire gLEDA1;
wire rLEDA1;
wire dLEDA1;
wire gLEDA2;
wire rLEDA2;
wire dLEDA2;
wire gLEDA3;
wire rLEDA3;
wire dLEDA3;
wire gLEDB1;
wire rLEDB1;
wire dLEDB1;
wire gLEDB2;
wire rLEDB2;
wire dLEDB2;
wire gLEDB3;
wire rLEDB3;
wire dLEDB3;
wire gLEDC1;
wire rLEDC1;
wire dLEDC1;
wire gLEDC2;
wire rLEDC2;
wire dLEDC2;
wire gLEDC3;
wire rLEDC3;
wire dLEDC3;
wire [3:0] anx;
wire [7:0] value;

vending_machine #(0) machine(
    .A1_n(A1_n),
    .A2_n(A2_n),
    .A3_n(A3_n),
    .B1_n(B1_n),
    .B2_n(B2_n),
    .B3_n(B3_n),
    .C1_n(C1_n),
    .C2_n(C2_n),
    .C3_n(C3_n),
    .nickel_n(nickel_n),
    .dime_n(dime_n),
    .quarter_n(quarter_n),
    .fifty_n(fifty_n),
    .dollar_n(dollar_n),
    .five_n(five_n),
    .cancelReset_n(cancelReset_n),
    .coinsDisp_n(coinsDisp_n),
    .clk(clk),
    .gLEDA1(gLEDA1),
    .rLEDA1(rLEDA1),
    .dLEDA1(dLEDA1),
    .gLEDA2(gLEDA2),
    .rLEDA2(rLEDA2),
    .dLEDA2(dLEDA2),
    .gLEDA3(gLEDA3),
    .rLEDA3(rLEDA3),
    .dLEDA3(dLEDA3),
    .gLEDB1(gLEDB1),
    .rLEDB1(rLEDB1),
    .dLEDB1(dLEDB1),
    .gLEDB2(gLEDB2),
    .rLEDB2(rLEDB2),
    .dLEDB2(dLEDB2),
    .gLEDB3(gLEDB3),
    .rLEDB3(rLEDB3),
    .dLEDB3(dLEDB3),
    .gLEDC1(gLEDC1),
    .rLEDC1(rLEDC1),
    .dLEDC1(dLEDC1),
    .gLEDC2(gLEDC2),
    .rLEDC2(rLEDC2),
    .dLEDC2(dLEDC2),
    .gLEDC3(gLEDC3),
    .rLEDC3(rLEDC3),
    .dLEDC3(dLEDC3),
    .anx(anx),
    .value(value)
    );

initial begin
    //$dumpfile("out.vcd");
    //$dumpvars(0, machine);

    $monitor("A1 %0b%0b A2 %0b%0b A3 %0b%0b\nB1 %0b%0b B2 %0b%0b B3 %0b%0b\nC1 %0b%0b C2 %0b%0b C3 %0b%0b\n\nA1 %0b A2 %0b A3 %0b B1 %0b B2 %0b B3 %0b C1 %0b C2 %0b C3 %0b", rLEDA1, gLEDA1, rLEDA2, gLEDA2, rLEDA3, gLEDA3, rLEDB1, gLEDB1, rLEDB2, gLEDB2, rLEDB3, gLEDB3, rLEDC1, gLEDC1, rLEDC2, gLEDC2, rLEDC3, gLEDC3, dLEDA1, dLEDA2, dLEDA3, dLEDB1, dLEDB2, dLEDB3, dLEDC1, dLEDC2, dLEDC3);
    
    // check all prices
    #1 A1_n = 1;
    $display("\nA1_n = 1");
    #1 A1_n = 0;
    
    #1 A2_n = 1;
    $display("A2_n = 1");
    #1 A2_n = 0;
    
    #1 A3_n = 1;
    $display("A3_n = 1");
    #1 A3_n = 0;
    
    #1 B1_n = 1;
    $display("B1_n = 1");
    #1 B1_n = 0;
    
    #1 B2_n = 1;
    $display("B2_n = 1");
    #1 B2_n = 0;
    
    #1 B3_n = 1;
    $display("B3_n = 1");
    #1 B3_n = 0;
    
    #1 C1_n = 1;
    $display("C1_n = 1");
    #1 C1_n = 0;
    
    #1 C2_n = 1;
    $display("C2_n = 1");
    #1 C2_n = 0;
    
    #1 coinsDisp_n = 0;
    $display("coinsDisp_n = 0");
    #1 coinsDisp_n = 1;
    
    #1 C3_n = 1;
    $display("C3_n = 1");
    #1 C3_n = 0;
    
    #1 nickel_n = 1;
    $display("nickel_n = 1");
    #1 nickel_n = 0;
    
    #1 cancelReset_n = 1;
    $display("cancelReset_n = 1");
    #1 cancelReset_n = 0;
    
    #1 A1_n = 1;
    $display("A1_n = 1");
    #1 A1_n = 0;
    
    // insert coins
    #1 nickel_n = 1;
    $display("nickel_n = 1");
    #1 nickel_n = 0;
    
    #1 nickel_n = 1;
    $display("nickel_n = 1");
    #1 nickel_n = 0;
    
    #1 A1_n = 1;
    $display("A1_n = 1");
    #1 A1_n = 0;
    
    #1 nickel_n = 1;
    $display("nickel_n = 1");
    #1 nickel_n = 0;
    
    #1 dollar_n = 1;
    $display("dollar_n = 1");
    #1 dollar_n = 0;
    
    #1 A1_n = 1;
    $display("A1_n = 1");
    #1 A1_n = 0;
    
    #1000 $finish;
end
    
endmodule