vlog openMSP430_defines.v
vcom -2008 openMSP430_pkg.vhd

vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/omsp_uart/rtl/omsp_uart_pkg.vhd

vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/template_periph_16b.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/template_periph_8b.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/omsp_timerA_undefines.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/omsp_timerA_defines.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/omsp_timerA.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/periph/omsp_gpio.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/openMSP430_undefines.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/openMSP430.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_watchdog.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_wakeup_cell.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_sync_reset.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_sync_cell.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_sfr.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_scan_mux.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_register_file.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_multiplier.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_mem_backbone.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_frontend.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_execution_unit.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_dbg_uart.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_dbg_i2c.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_dbg_hwbrk.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_dbg.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_clock_mux.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_clock_module.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_clock_gate.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_and_gate.v
vlog $LIBSOFTCORE_PATH/opencores/openmsp430/core/rtl/verilog/omsp_alu.v
vlog $LIBSOFTCORE_PATH/opencores/omsp_uart/omsp_uart.v

vcom -2008 $LIBSOFTCORE_PATH/src/packages/math/log2_pkg.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/packages/math/body/log2_pkg-body.vhd


vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/per_iface/rtl/per_iface_pkg.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/per_iface/rtl/per_iface_entity.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/per_iface/rtl/per_iface_arch.vhd

vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/pwm_pkg.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/pwm_entity.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/pwm_arch.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/per_pwm_pkg.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/per_pwm_entity.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/per_pwm/rtl/per_pwm_arch.vhd

vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/ram16/rtl/ram16_pkg.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/ram16/rtl/init_ram16_pkg.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/ram16/rtl/ram16_entity.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/ram16/rtl/ram16_arch.vhd

vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/omsp_timerA/rtl/omsp_timerA_pkg.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/omsp_gpio/rtl/omsp_gpio_pkg.vhd

vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/dma_test/rtl/dma_test_pkg.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/dma_test/rtl/dma_test_entity.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/dma_test/rtl/dma_test_arch.vhd
vcom -2008 $LIBSOFTCORE_PATH/src/omsp_peripherals/dma_test/rtl/dma_test_tb.vhd

vcom -2008 mcu.vhd
vcom -2008 mcu_tb.vhd
