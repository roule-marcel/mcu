library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.openMSP430_pkg.all;
use work.omsp_gpio_pkg.all;
use work.omsp_timerA_pkg.all;
use work.omsp_uart_pkg.all;
use work.per_pwm_pkg.all;
use work.ram16_pkg.all;

use work.helpers_pkg.all;

entity mcu_tb is
end entity mcu_tb;

architecture test_bench of mcu_tb is
	component mcu is
		port (
			-- overall clock
			clk_sys : in std_logic;
			-- reset
			reset_n : in std_logic;
	
			uart_txd : out std_logic;
			uart_rxd : in std_logic;
	
			leds : out std_logic_vector(7 downto 0);
			sw : in std_logic_vector(7 downto 0);
	
			pwm_a_0 : out std_logic;
			pwm_b_0 : out std_logic;
			pwm_a_1 : out std_logic;
			pwm_b_1 : out std_logic
		);
	end component mcu;

	signal tb_clk_sys : std_logic;
	signal tb_reset_n : std_logic;
	signal tb_uart_txd : std_logic;
	signal tb_uart_rxd : std_logic;
	signal tb_leds : std_logic_vector(7 downto 0);
	signal tb_sw : std_logic_vector(7 downto 0);
	signal tb_pwm_a_0 : std_logic;
	signal tb_pwm_b_0 : std_logic;
	signal tb_pwm_a_1 : std_logic;
	signal tb_pwm_b_1 : std_logic;

	signal simu_ended : boolean := false;
begin
	cut: mcu 
		port map (
			-- overall clock
			clk_sys => tb_clk_sys,
			-- reset
			reset_n => tb_reset_n,
	
			uart_txd => tb_uart_txd,
			uart_rxd => tb_uart_rxd,
	
			leds => tb_leds,
			sw => tb_sw,
	
			pwm_a_0 => tb_pwm_a_0,
			pwm_b_0 => tb_pwm_b_0,
			pwm_a_1 => tb_pwm_a_1,
			pwm_b_1 => tb_pwm_b_1
		);

	p_clk_sys: process
	begin
		while (simu_ended = false) loop
			-- 24 MHz
			tb_clk_sys <= '0'; wait for 20.833 ns;
			tb_clk_sys <= '1'; wait for 20.833 ns;
		end loop;
		wait;
	end process p_clk_sys;

	p_test_bench: process
	begin
		tb_reset_n <= '1';

		tb_uart_rxd <= '0';
		tb_sw <= (others => '0');

		for i in 0 to 9 loop
			wait until rising_edge(tb_clk_sys);
		end loop;

		tb_reset_n <= '0';

		for i in 0 to 9 loop
			wait until rising_edge(tb_clk_sys);
		end loop;

		tb_reset_n <= '1' after 2 ns;
		tb_uart_rxd <= '1' after 2 ns;

		for i in 0 to 15000 loop
			wait until rising_edge(tb_clk_sys);
		end loop;

        sendSerial(162, 115200.0, 0, 1.0, 7, 0.0, tb_uart_rxd);
		tb_sw <= x"0A";
        sendSerial(225, 115200.0, 0, 1.0, 7, 0.0, tb_uart_rxd);
		tb_sw <= x"0B";
        sendSerial(162, 115200.0, 0, 1.0, 7, 0.0, tb_uart_rxd);
		tb_sw <= x"0C";
        sendSerial(225, 115200.0, 0, 1.0, 7, 0.0, tb_uart_rxd);
		tb_sw <= x"0D";
        sendSerial(0, 115200.0, 0, 1.0, 7, 0.0, tb_uart_rxd);
		tb_sw <= x"0E";
        sendSerial(224, 115200.0, 0, 1.0, 7, 0.0, tb_uart_rxd);
		tb_sw <= x"0F";

		for i in 0 to 10000 loop
			wait until rising_edge(tb_clk_sys);
		end loop;

		simu_ended <= true;
		wait;
	end process p_test_bench;
end architecture test_bench;
