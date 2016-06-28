#Clock
set_location_assignment PIN_R8 -to clk_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to clk_50

#Keys
##GPIO_013
set_location_assignment PIN_D6 -to keys[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to keys[0]
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to keys[0]
##GPIO_021 (TODO loc)
set_location_assignment PIN_F8 -to keys[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to keys[1]
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to keys[1]

#LEDs
set_location_assignment PIN_A15 -to leds[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[0]
set_location_assignment PIN_A13 -to leds[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[1]
set_location_assignment PIN_B13 -to leds[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[2]
set_location_assignment PIN_A11 -to leds[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[3]
set_location_assignment PIN_D1 -to leds[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[4]
set_location_assignment PIN_F3 -to leds[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[5]
set_location_assignment PIN_B1 -to leds[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[6]
set_location_assignment PIN_L3 -to leds[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[7]

#Buzzer pouit!
##GPIO_032
set_location_assignment PIN_D12 -to buzzer
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to buzzer

#UART Bluetooth
##GPIO_025
set_location_assignment PIN_D9 -to uart_bluetooth_rxd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart_bluetooth_rxd
##GPIO_027
set_location_assignment PIN_E10 -to uart_bluetooth_txd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart_bluetooth_txd

#PWM
##GPIO_030
set_location_assignment PIN_A12 -to pwm_l_a
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pwm_l_a
##GPIO_028
set_location_assignment PIN_C11 -to pwm_l_en
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pwm_l_en
##GPIO_026
set_location_assignment PIN_E11 -to pwm_r_a
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pwm_l_b
##GPIO_033
set_location_assignment PIN_B12 -to pwm_l_b
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pwm_r_a
##GPIO_031
set_location_assignment PIN_D11 -to pwm_r_en
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pwm_r_en
##GPIO_029
set_location_assignment PIN_B11 -to pwm_r_b
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to pwm_r_b

#QEI (TODO LOC)
##GPIO_016
set_location_assignment PIN_C8 -to qei_l_a
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to qei_l_a
##GPIO_014
set_location_assignment PIN_A7 -to qei_l_b
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to qei_l_b
##GPIO_012
set_location_assignment PIN_B7 -to qei_r_a
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to qei_r_a
##GPIO_010
set_location_assignment PIN_B6 -to qei_r_b
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to qei_r_b
