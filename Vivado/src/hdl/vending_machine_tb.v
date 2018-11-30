`include "vending_machine.v"

module vending_machine_tb();

reg north_ped_sig;
reg west_ped_sig;
reg reset_n;
reg clk;

wire debug;
wire red_0;
wire ylw_0;
wire grn_0;
wire red_1;
wire ylw_1;
wire grn_1;

vending_machine #(0) two_way(
    .debug(debug),
    .red_0(red_0),
    .ylw_0(ylw_0),
    .grn_0(grn_0),
    .red_1(red_1),
    .ylw_1(ylw_1),
    .grn_1(grn_1),
    .crosswalk_0(north_ped_sig),
    .crosswalk_1(west_ped_sig),
    .reset_n(reset_n),
    .clk(clk)
);

initial begin
    clk = 0;
    north_ped_sig = 'b0;
    west_ped_sig  = 'b0;
    reset_n = 'b1;
    #10 reset_n = 'b0;
end

initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,two_way);
end

initial begin
    @(negedge reset_n) begin $display("start"); end
    $monitor("%000d\tRYG0 = %b%b%b RYG1 = %b%b%b",$time, red_0, ylw_0, grn_0, red_1, ylw_1, grn_1);
    #1000 $finish;
end

always #1 clk = ~clk;
    
endmodule