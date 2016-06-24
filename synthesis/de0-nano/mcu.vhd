library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.openMSP430_pkg.all;
use work.omsp_gpio_pkg.all;
use work.omsp_timerA_pkg.all;
use work.omsp_uart_pkg.all;
use work.uart_bootloader_pkg.all;
use work.per_pwm_pkg.all;
use work.per_qei_pkg.all;
use work.ram16_pkg.all;

entity mcu is
	port (
		clk_50 : in std_logic;

		keys : in std_logic_vector(1 downto 0);
		leds : out std_logic_vector(7 downto 0);
		buzzer : out std_logic;

		uart_bluetooth_rxd : in std_logic;
		uart_bluetooth_txd : out std_logic;

		pwm_l_a : out std_logic;
		pwm_l_b : out std_logic;
		pwm_l_en : out std_logic;
		pwm_r_a : out std_logic;
		pwm_r_b : out std_logic;
		pwm_r_en : out std_logic;

		qei_l_a : in std_logic;
		qei_l_b : in std_logic;
		qei_r_a : in std_logic;
		qei_r_b : in std_logic
	);
end entity mcu;

architecture rtl of mcu is
	component pll is
	port (
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
	end component pll;

	-- overall clock
	signal clk_sys : std_logic;
	-- reset
	signal reset_n : std_logic;
	-- openMSP430 output buses
	signal per_addr : std_logic_vector(13 downto 0);
	signal per_din : std_logic_vector(15 downto 0);
	signal per_we : std_logic_vector(1 downto 0);
	signal dmem_addr : std_logic_vector(DMEM_MSB downto 0); -- Arbitrary 16x512
	signal dmem_din : std_logic_vector(15 downto 0);
	signal dmem_wen : std_logic_vector(1 downto 0);
	signal dmem_wren : std_logic;
	signal pmem_addr : std_logic_vector(PMEM_MSB downto 0); -- Arbitrary 16x2048
	signal pmem_din : std_logic_vector(15 downto 0);
	signal pmem_wen : std_logic_vector(1 downto 0);
	signal pmem_wren : std_logic;
	signal irq_acc : std_logic_vector(13 downto 0);
	-- openMSP430 input buses
	signal irq_bus : std_logic_vector(13 downto 0);
	signal per_dout : std_logic_vector(15 downto 0);
	signal dmem_dout : std_logic_vector(15 downto 0);
	signal pmem_dout : std_logic_vector(15 downto 0);
	-- GPIO
	signal p1_din : std_logic_vector(7 downto 0);
	signal p1_dout : std_logic_vector(7 downto 0);
	signal p1_dout_en : std_logic_vector(7 downto 0);
	signal p1_sel : std_logic_vector(7 downto 0);
	signal p2_din : std_logic_vector(7 downto 0);
	signal p2_dout : std_logic_vector(7 downto 0);
	signal p2_dout_en : std_logic_vector(7 downto 0);
	signal p2_sel : std_logic_vector(7 downto 0);
	signal p3_din : std_logic_vector(7 downto 0);
	signal p3_dout : std_logic_vector(7 downto 0);
	signal p3_dout_en : std_logic_vector(7 downto 0);
	signal p3_sel : std_logic_vector(7 downto 0);
	signal per_dout_dio : std_logic_vector(15 downto 0);
	-- Timer A
	signal per_dout_tA : std_logic_vector(15 downto 0);
	-- 7 segment driver
	signal per_dout_7seg : std_logic_vector(15 downto 0);
	-- Others
	signal reset_pin : std_logic;

	-- TODO sort that shit
	signal cpu_reset_n : std_logic;
	signal cpu_en : std_logic;
	signal aclk_en : std_logic;
	signal dbg_freeze : std_logic;
	signal dbg_uart_txd : std_logic;
	signal dmem_cen : std_logic;
	signal mclk : std_logic;
	signal per_en : std_logic;
	signal pmem_cen : std_logic;
	signal puc_rst : std_logic;
	signal smclk_en : std_logic;
	signal dbg_uart_rxd : std_logic;
	signal nmi : std_logic;
	signal irq_port1 : std_logic;
	signal irq_port2 : std_logic;
	signal irq_ta0 : std_logic;
	signal irq_ta1 : std_logic;
	signal ta_out0 : std_logic;
	signal ta_out0_en : std_logic;
	signal ta_out1 : std_logic;
	signal ta_out1_en : std_logic;
	signal ta_out2 : std_logic;
	signal ta_out2_en : std_logic;
	signal inclk : std_logic;
	signal ta_cci0a : std_logic;
	signal ta_cci0b : std_logic;

	signal ta_cci1a : std_logic;
	signal ta_cci2a : std_logic;
	signal taclk : std_logic;

	signal dma_dout : std_logic_vector(15 downto 0);   -- Direct Memory Access data output
	signal dma_ready : std_logic;                      -- Direct Memory Access is complete
	signal dma_resp : std_logic;                       -- Direct Memory Access response (0:Okay / 1:Error)

	signal dma_addr : std_logic_vector(15 downto 1);  -- Direct Memory Access address
	signal dma_din : std_logic_vector(15 downto 0);   -- Direct Memory Access data input
	signal dma_en : std_logic;                        -- Direct Memory Access enable (high active)
	signal dma_priority : std_logic;                  -- Direct Memory Access priority (0:low / 1:high)
	signal dma_we : std_logic_vector(1 downto 0);     -- Direct Memory Access write byte enable (high active)

	-- Simple UART
	signal irq_uart_rx : std_logic;
	signal irq_uart_tx : std_logic;
	signal per_dout_uart : std_logic_vector(15 downto 0);
	signal hw_uart_txd : std_logic;
	signal hw_uart_rxd : std_logic;

	-- PWM Modules
	signal per_dout_pwm_l : std_logic_vector(15 downto 0);
	signal per_dout_pwm_r : std_logic_vector(15 downto 0);

	-- Bootloader
	signal per_dout_uart_bootloader : std_logic_vector(15 downto 0);
	signal cpu_reset_bootloader_n : std_logic;

	-- QEI
	signal per_dout_qei_l : std_logic_vector(15 downto 0);
	signal per_dout_qei_r : std_logic_vector(15 downto 0);
begin
	pll_24: pll
	port map (
		areset => not keys(0),
		inclk0 => clk_50,
		c0 => clk_sys,
		locked => reset_n
	);

	cpu_reset_n <= reset_n and cpu_reset_bootloader_n;
	cpu_en <= not dma_priority;

	pwm_l_en <= '1';
	pwm_r_en <= '1';

	cpu_0: openMSP430
		generic map (
			INST_NR => (others => '0'),
			TOTAL_NR => (others => '0')
		)
		port map (
			aclk => open,
			aclk_en => aclk_en,
			dbg_freeze => dbg_freeze,
			dbg_i2c_sda_out => open,
			dbg_uart_txd => dbg_uart_txd,
			dco_enable => open,
			dco_wkup => open,
			dmem_addr => dmem_addr,
			dmem_cen => dmem_cen,
			dmem_din => dmem_din,
			dmem_wen => dmem_wen,
			irq_acc => irq_acc,
			lfxt_enable => open,
			lfxt_wkup => open,
			mclk => mclk,
			dma_dout => dma_dout,
			dma_ready => dma_ready,
			dma_resp => dma_resp,
			per_addr => per_addr,
			per_din => per_din,
			per_en => per_en,
			per_we => per_we,
			pmem_addr => pmem_addr,
			pmem_cen => pmem_cen,
			pmem_din => pmem_din,
			pmem_wen => pmem_wen,
			puc_rst => puc_rst,
			smclk => open,
			smclk_en => smclk_en,

			cpu_en => cpu_en,
			dbg_en => '0',
			dbg_i2c_addr => (others => '0'),
			dbg_i2c_broadcast => (others => '0'),
			dbg_i2c_scl => '1',
			dbg_i2c_sda_in => '1',
			dbg_uart_rxd => dbg_uart_rxd,
			dco_clk => clk_sys,
			dmem_dout => dmem_dout,
			irq => irq_bus,
			lfxt_clk => '0',
			dma_addr => dma_addr,
			dma_din => dma_din,
			dma_en => dma_en,
			dma_priority => dma_priority,
			dma_we => dma_we,
			dma_wkup => '0',
			nmi => nmi,
			per_dout => per_dout,
			pmem_dout => pmem_dout,
			reset_n => cpu_reset_n,
			scan_enable => '0',
			scan_mode => '0',
			wkup => '0'
		);

	-- @0x0190 -> @0x0198
	bootloader: uart_bootloader
		generic map (
			-- Register base address (must be aligned to decoder bit width)
			BASE_ADDR => 15x"0190"
		)
		port map (
			-- Memory mapped peripheral side
			-- Configure Code memory range and start re-programmation
			per_dout => per_dout_uart_bootloader,
	
			mclk => mclk,
			per_addr => per_addr,
			per_din => per_din,
			per_en => per_en,
			per_we => per_we,
			puc_rst => puc_rst,
	
			-- DMA side
			-- Actually re-program the MCU
			dma_dout => dma_dout,
			dma_ready => dma_ready,
			dma_resp => dma_resp,
	
			dma_addr => dma_addr,
			dma_din => dma_din,
			dma_en => dma_en,
			dma_priority => dma_priority,
			dma_we => dma_we,

			cpu_reset_n => cpu_reset_bootloader_n,
	
			uart_rxd => uart_bluetooth_rxd
		);

	-- @0x0198 -> @0x019A
	qei_l: per_qei
		generic map (
			-- Register base address (must be aligned to decoder bit width)
			BASE_ADDR => 15x"0198"
		)
		port map (
			per_dout => per_dout_qei_l,
	
			mclk => mclk,
			per_addr => per_addr,
			per_din => per_din,
			per_en => per_en,
			per_we => per_we,
			puc_rst => puc_rst,
	
			qei_a => qei_l_a,
			qei_b => qei_l_b
		);

	-- @0x019A -> @0x019C
	qei_r: per_qei
		generic map (
			-- Register base address (must be aligned to decoder bit width)
			BASE_ADDR => 15x"019A"
		)
		port map (
			per_dout => per_dout_qei_r,
	
			mclk => mclk,
			per_addr => per_addr,
			per_din => per_din,
			per_en => per_en,
			per_we => per_we,
			puc_rst => puc_rst,
	
			qei_a => qei_r_a,
			qei_b => qei_r_b
		);

	-- @0x0000 -> 0x003F
	c_gpio_0: omsp_gpio
		generic map (
			P1_EN => "1",
			P2_EN => "1",
			P3_EN => "1",
			P4_EN => "0",
			P5_EN => "0",
			P6_EN => "0"
		)
		port map (
			irq_port1 => irq_port1,
			irq_port2 => irq_port2,
			p1_dout => p1_dout,
			p1_dout_en => p1_dout_en,
			p1_sel => p1_sel,
			p2_dout => p2_dout,
			p2_dout_en => p2_dout_en,
			p2_sel => p2_sel,
			p3_dout => p3_dout,
			p3_dout_en => p3_dout_en,
			p3_sel => p3_sel,
			p4_dout => open,
			p4_dout_en => open,
			p4_sel => open,
			p5_dout => open,
			p5_dout_en => open,
			p5_sel => open,
			p6_dout => open,
			p6_dout_en => open,
			p6_sel => open,
			per_dout => per_dout_dio,

			mclk => mclk,
			p1_din => p1_din,
			p2_din => p2_din,
			p3_din => p3_din,
			p4_din => (others => '0'),
			p5_din => (others => '0'),
			p6_din => (others => '0'),
			per_addr => per_addr,
			per_din => per_din,
			per_en => per_en,
			per_we => per_we,
			puc_rst => puc_rst
		);

	-- @0x0100 -> @0x017F
	timerA_0: omsp_timerA
		port map(
			irq_ta0 => irq_ta0,
			irq_ta1 => irq_ta1,
			per_dout => per_dout_tA,
			ta_out0 => ta_out0,
			ta_out0_en => ta_out0_en,
			ta_out1 => ta_out1,
			ta_out1_en => ta_out1_en,
			ta_out2 => ta_out2,
			ta_out2_en => ta_out2_en,
			
			aclk_en => aclk_en,
			dbg_freeze => dbg_freeze,
			inclk => inclk,
			irq_ta0_acc => irq_acc(9),
			mclk => mclk,
			per_addr => per_addr,
			per_din => per_din,
			per_en => per_en,
			per_we => per_we,
			puc_rst => puc_rst,
			smclk_en => smclk_en,
			ta_cci0a => ta_cci0a,
			ta_cci0b => ta_cci0b,
			ta_cci1a => ta_cci1a,
			ta_cci1b => '0',
			ta_cci2a => ta_cci2a,
			ta_cci2b => '0',
			taclk => taclk
		);

	-- @0x0080 -> 0x0087
	uart_0: omsp_uart
		generic map (
			-- Register base address (must be aligned to decoder bit width)
			BASE_ADDR => 15x"0080" -- Should work in VHDL'2008
--			BASE_ADDR => "000" & x"080" -- Fuck VHDL'95
		)
		port map (
			irq_uart_rx => irq_uart_rx,
			irq_uart_tx => irq_uart_tx,
			per_dout => per_dout_uart,
			uart_txd => hw_uart_txd,

			mclk => mclk,
			per_addr => per_addr,
			per_din => per_din,
			per_en => per_en,
			per_we => per_we,
			puc_rst => puc_rst,
			smclk_en => smclk_en,
			uart_rxd => hw_uart_rxd
		);

	-- @0x0100 -> 0x0107
	per_pwm_l: per_pwm
	generic map (
		-- Register base address (must be aligned to decoder bit width)
		BASE_ADDR => 15x"0180"
	)
	port map (
		per_dout => per_dout_pwm_l,
	
		mclk => mclk,
		per_addr => per_addr,
		per_din => per_din,
		per_en => per_en,
		per_we => per_we,
		puc_rst => puc_rst,

		pwm_a => pwm_l_a,
		pwm_b => pwm_l_b
	);

	-- @0x0108 -> 0x010F
	per_pwm_r: per_pwm
	generic map (
		-- Register base address (must be aligned to decoder bit width)
		BASE_ADDR => 15x"0188"
	)
	port map (
		per_dout => per_dout_pwm_r,
	
		mclk => mclk,
		per_addr => per_addr,
		per_din => per_din,
		per_en => per_en,
		per_we => per_we,
		puc_rst => puc_rst,

		pwm_a => pwm_r_a,
		pwm_b => pwm_r_b
	);

	-- Combine peripheral data buses
	---------------------------------
	per_dout <= per_dout_dio or per_dout_tA or per_dout_uart or per_dout_pwm_l or per_dout_pwm_r or per_dout_uart_bootloader;

	-- Assign interrupts
	---------------------------------
	nmi <= '0';
	irq_bus <= 
		'0' &          -- Vector 13  (0xFFFA)
		'0' &          -- Vector 12  (0xFFF8)
		'0' &          -- Vector 11  (0xFFF6)
		'0' &          -- Vector 10  (0xFFF4) - Watchdog -
		irq_ta0 &      -- Vector  9  (0xFFF2)
		irq_ta1 &      -- Vector  8  (0xFFF0)
		irq_uart_rx &  -- Vector  7  (0xFFEE)
		irq_uart_tx &  -- Vector  6  (0xFFEC)
		'0' &          -- Vector  5  (0xFFEA)
		'0' &          -- Vector  4  (0xFFE8)
		irq_port2 &    -- Vector  3  (0xFFE6)
		irq_port1 &    -- Vector  2  (0xFFE4)
		'0' &          -- Vector  1  (0xFFE2)
		'0';           -- Vector  0  (0xFFE0)

	dram: ram16
		generic map (
			DEPTH => 2**DMEM_AWIDTH,
			INIT_FILE => "none"
		)
		port map (
			clk => clk_sys,
			cen => dmem_cen,
			addr => dmem_addr(DMEM_MSB downto 0),
			din => dmem_din,
			wen => dmem_wen,
			dout => dmem_dout
		);

	pram: ram16
		generic map (
			DEPTH => 2**PMEM_AWIDTH,
			INIT_FILE => "mcu_firmware"
		)
		port map (
			clk => clk_sys,
			cen => pmem_cen,
			addr => pmem_addr(PMEM_MSB downto 0),
			din => pmem_din,
			wen => pmem_wen,
			dout => pmem_dout
		);

--	p1_din(7 downto 0) <= SW(7 downto 0);
	leds <= p3_dout and p3_dout_en;

	-- RS-232 Port
	------------------------
	uart_bluetooth_txd <= hw_uart_txd;
	hw_uart_rxd <= uart_bluetooth_rxd;
end architecture rtl;
