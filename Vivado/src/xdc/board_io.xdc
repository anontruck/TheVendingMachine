# SWITCHES:

set_property PACKAGE_PIN R2 [get_ports A1]
set_property IOSTANDARD LVCMOS33 [get_ports A1]

set_property PACKAGE_PIN T1 [get_ports A2]
set_property IOSTANDARD LVCMOS33 [get_ports A2]

set_property PACKAGE_PIN U1 [get_ports A3]
set_property IOSTANDARD LVCMOS33 [get_ports A3]

set_property PACKAGE_PIN W2 [get_ports B1]
set_property IOSTANDARD LVCMOS33 [get_ports B1]

set_property PACKAGE_PIN R3 [get_ports B2]
set_property IOSTANDARD LVCMOS33 [get_ports B2]

set_property PACKAGE_PIN T2 [get_ports B3]
set_property IOSTANDARD LVCMOS33 [get_ports B3]

set_property PACKAGE_PIN T3 [get_ports C1]
set_property IOSTANDARD LVCMOS33 [get_ports C1]

set_property PACKAGE_PIN V2 [get_ports C2]
set_property IOSTANDARD LVCMOS33 [get_ports C2]

set_property PACKAGE_PIN W13 [get_ports C3]
set_property IOSTANDARD LVCMOS33 [get_ports C3]

set_property PACKAGE_PIN V16 [get_ports cancelReset]
set_property IOSTANDARD LVCMOS33 [get_ports cancelReset]

set_property PACKAGE_PIN V17 [get_ports coinsDisp]
set_property IOSTANDARD LVCMOS33 [get_ports coinsDisp]

# BUTTONS:

set_property PACKAGE_PIN T18 [get_ports nickel]
set_property IOSTANDARD LVCMOS33 [get_ports nickel]

set_property PACKAGE_PIN T17 [get_ports dime]
set_property IOSTANDARD LVCMOS33 [get_ports dime]

set_property PACKAGE_PIN U17 [get_ports quarter]
set_property IOSTANDARD LVCMOS33 [get_ports quarter]

set_property PACKAGE_PIN W19 [get_ports dollar]
set_property IOSTANDARD LVCMOS33 [get_ports dollar]

set_property PACKAGE_PIN U18 [get_ports five]
set_property IOSTANDARD LVCMOS33 [get_ports five]

# CLK:

set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name external_clock -period 10.00 [get_ports clk]

# LEDS:

# JA:

set_property PACKAGE_PIN G2 [get_ports gLEDA1]
set_property IOSTANDARD LVCMOS33 [get_ports gLEDA1]

set_property PACKAGE_PIN J2 [get_ports gLEDB1]
set_property IOSTANDARD LVCMOS33 [get_ports gLEDB1]

set_property PACKAGE_PIN L2 [get_ports gLEDC1]
set_property IOSTANDARD LVCMOS33 [get_ports gLEDC1]

set_property PACKAGE_PIN G3 [get_ports rLEDA1]
set_property IOSTANDARD LVCMOS33 [get_ports rLEDA1]

set_property PACKAGE_PIN H2 [get_ports rLEDB1]
set_property IOSTANDARD LVCMOS33 [get_ports rLEDB1]

set_property PACKAGE_PIN K2 [get_ports rLEDC1]
set_property IOSTANDARD LVCMOS33 [get_ports rLEDC1]

# JB:

set_property PACKAGE_PIN A14 [get_ports gLEDA2]
set_property IOSTANDARD LVCMOS33 [get_ports gLEDA2]

set_property PACKAGE_PIN A16 [get_ports gLEDB2]
set_property IOSTANDARD LVCMOS33 [get_ports gLEDB2]

set_property PACKAGE_PIN B15 [get_ports gLEDC2]
set_property IOSTANDARD LVCMOS33 [get_ports gLEDC2]

set_property PACKAGE_PIN A15 [get_ports rLEDA2]
set_property IOSTANDARD LVCMOS33 [get_ports rLEDA2]

set_property PACKAGE_PIN A17 [get_ports rLEDB2]
set_property IOSTANDARD LVCMOS33 [get_ports rLEDB2]

set_property PACKAGE_PIN C15 [get_ports rLEDC2]
set_property IOSTANDARD LVCMOS33 [get_ports rLEDC2]

# JC:

set_property PACKAGE_PIN K17 [get_ports gLEDA3]
set_property IOSTANDARD LVCMOS33 [get_ports gLEDA3]

set_property PACKAGE_PIN M18 [get_ports gLEDB3]
set_property IOSTANDARD LVCMOS33 [get_ports gLEDB3]

set_property PACKAGE_PIN N17 [get_ports gLEDC3]
set_property IOSTANDARD LVCMOS33 [get_ports gLEDC3]

set_property PACKAGE_PIN L17 [get_ports rLEDA3]
set_property IOSTANDARD LVCMOS33 [get_ports rLEDA3]

set_property PACKAGE_PIN M19 [get_ports rLEDB3]
set_property IOSTANDARD LVCMOS33 [get_ports rLEDB3]

set_property PACKAGE_PIN P17 [get_ports rLEDC3]
set_property IOSTANDARD LVCMOS33 [get_ports rLEDC3]

# BOARD LEDS:

set_property PACKAGE_PIN L1 [get_ports dLEDA1]
set_property IOSTANDARD LVCMOS33 [get_ports dLEDA1]

set_property PACKAGE_PIN P1 [get_ports dLEDA2]
set_property IOSTANDARD LVCMOS33 [get_ports dLEDA2]

set_property PACKAGE_PIN N3 [get_ports dLEDA3]
set_property IOSTANDARD LVCMOS33 [get_ports dLEDA3]

set_property PACKAGE_PIN P3 [get_ports dLEDB1]
set_property IOSTANDARD LVCMOS33 [get_ports dLEDB1]

set_property PACKAGE_PIN U3 [get_ports dLEDB2]
set_property IOSTANDARD LVCMOS33 [get_ports dLEDB2]

set_property PACKAGE_PIN W3 [get_ports dLEDB3]
set_property IOSTANDARD LVCMOS33 [get_ports dLEDB3]

set_property PACKAGE_PIN V3 [get_ports dLEDC1]
set_property IOSTANDARD LVCMOS33 [get_ports dLEDC1]

set_property PACKAGE_PIN V13 [get_ports dLEDC2]
set_property IOSTANDARD LVCMOS33 [get_ports dLEDC2]

set_property PACKAGE_PIN V14 [get_ports dLEDC3]
set_property IOSTANDARD LVCMOS33 [get_ports dLEDC3]

# BOARD 7SD:

# Constraints for CLK
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -name external_clock -period 10.00 [get_ports clk]

# Constraints for AN0
set_property PACKAGE_PIN U2 [get_ports {anx[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anx[0]}]

# Constraints for AN1
set_property PACKAGE_PIN U4 [get_ports {anx[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anx[1]}]

# Constraints for AN2
set_property PACKAGE_PIN V4 [get_ports {anx[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anx[2]}]

# Constraints for AN3
set_property PACKAGE_PIN W4 [get_ports {anx[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anx[3]}]

# 7SD
set_property PACKAGE_PIN U7 [get_ports {value[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {value[7]}]

set_property PACKAGE_PIN V5 [get_ports {value[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {value[6]}]

set_property PACKAGE_PIN U5 [get_ports {value[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {value[5]}]

set_property PACKAGE_PIN V8 [get_ports {value[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {value[4]}]

set_property PACKAGE_PIN U8 [get_ports {value[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {value[3]}]

set_property PACKAGE_PIN W6 [get_ports {value[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {value[2]}]

set_property PACKAGE_PIN W7 [get_ports {value[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {value[1]}]

set_property PACKAGE_PIN V7 [get_ports {value[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {value[0]}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets coinsDisp_IBUF]