#set LIBSOFTCORE_PATH /home/laurent/documents/marcel/libsoftcore
#set LIBSOFTCORE_PATH $::env(LIBSOFTCORE_PATH)

puts "Reading file_assignment file"

if { [info exists ::env(LIBSOFTCORE_PATH)] } {
	set LIBSOFTCORE_PATH $::env(LIBSOFTCORE_PATH)
	puts "Found libsoftcore at $LIBSOFTCORE_PATH"
} else {
	puts "Error: libsoftcore path is not set"
	puts "Please set the LIBSOFTCORE_PATH environment variable"
	return -1
}

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/packages/math/log2_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/packages/math/body/log2_pkg-body.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_iface/rtl/per_iface_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_iface/rtl/per_iface_entity.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_iface/rtl/per_iface_arch.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/opencores/uart2bus/vhdl/rtl/uart2BusTop_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/opencores/uart2bus/vhdl/rtl/baudGen.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/opencores/uart2bus/vhdl/rtl/uartParser.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/opencores/uart2bus/vhdl/rtl/uartRx.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/opencores/uart2bus/vhdl/rtl/uartTop.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/opencores/uart2bus/vhdl/rtl/uartTx.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/uart_bootloader/rtl/uart_bootloader_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/uart_bootloader/rtl/uart_bootloader_arch.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/uart_bootloader/rtl/uart_bootloader_entity.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/pwm_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/pwm_entity.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/pwm_arch.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/per_pwm_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/per_pwm_entity.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/per_pwm_arch.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_qei/rtl/qei_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_qei/rtl/qei_entity.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_qei/rtl/qei_arch.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_qei/rtl/per_qei_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_qei/rtl/per_qei_entity.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_qei/rtl/per_qei_arch.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_buzzer/rtl/per_buzzer_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_buzzer/rtl/per_buzzer_entity.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_buzzer/rtl/per_buzzer_arch.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_srf05/rtl/srf05_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_srf05/rtl/srf05_entity.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_srf05/rtl/srf05_arch.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_srf05/rtl/per_srf05_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_srf05/rtl/per_srf05_entity.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/per_srf05/rtl/per_srf05_arch.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/ram16/rtl/init_ram16_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/ram16/rtl/ram16_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/ram16/rtl/ram16_entity.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/ram16/rtl/ram16_arch.vhd

set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/omsp_timerA/rtl/omsp_timerA_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/omsp_gpio/rtl/omsp_gpio_pkg.vhd
set_global_assignment -name VHDL_FILE $LIBSOFTCORE_PATH/src/omsp_peripherals/omsp_uart/rtl/omsp_uart_pkg.vhd

set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/template_periph_16b.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/template_periph_8b.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/omsp_timerA_undefines.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/omsp_timerA_defines.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/omsp_timerA.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/omsp_gpio.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/openMSP430_undefines.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/openMSP430.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_watchdog.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_wakeup_cell.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_sync_reset.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_sync_cell.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_sfr.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_scan_mux.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_register_file.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_multiplier.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_mem_backbone.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_frontend.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_execution_unit.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_dbg_uart.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_dbg_i2c.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_dbg_hwbrk.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_dbg.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_clock_mux.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_clock_module.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_clock_gate.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_and_gate.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_alu.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/OpenMSP430_fpga.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/ext_de1_sram.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/driver_7segment.v
set_global_assignment -name VERILOG_FILE $LIBSOFTCORE_PATH/opencores/omsp_uart/omsp_uart.v
