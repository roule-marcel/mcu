create_clock -name "clk_50" -period 20.000ns [get_ports {clk_50}]
create_clock -name "wdtctl[6]" -period 20.000ns [get_ports {cpu_0|omsp_watchdog:watchdog_0|wdtctl[6]}]

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

derive_clocks -period 20.000

# False paths
