library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity LED_shift_right_tb is
end entity LED_shift_right_tb;

architecture LED_shift_right_tb_arch of LED_shift_right_tb is

	/*component LED_shift_right is
		port(
			clk		: in std_ulogic;
			rst		: in std_ulogic;
			led_reg		: in std_ulogic_vector(7 downto 0);
			led		: out std_ulogic_vector(7 downto 0)
		);
	end component;

	component LED_shift_left_2 is
		port(
			clk		: in std_ulogic;
			rst		: in std_ulogic;
			led_reg		: in std_ulogic_vector(7 downto 0);
			led		: out std_ulogic_vector(7 downto 0)
		);
	end component;

	component LED_7bitUPcount is
		port(
			clk		: in std_ulogic;
			rst		: in std_ulogic;
			led_reg		: in std_ulogic_vector(7 downto 0);
			led		: out std_ulogic_vector(7 downto 0)
		);
	end component;

	component LED_7bitDOWNcount is
		port(
			clk		: in std_ulogic;
			rst		: in std_ulogic;
			led_reg		: in std_ulogic_vector(7 downto 0);
			led		: out std_ulogic_vector(7 downto 0)
		);
	end component;*/

	component LED_shiftINOUT is
		port(
			clk		: in std_ulogic;
			rst		: in std_ulogic;
			led_reg		: in std_ulogic_vector(7 downto 0);
			led		: out std_ulogic_vector(7 downto 0)
		);
	end component;

	signal clk_tb 		: std_ulogic := '0';
	signal rst_tb		: std_ulogic := '0';
	signal led_reg_tb	: std_ulogic_vector(7 downto 0) := "00000000";

	constant CLOCK_PERIOD	: time := 20 ns;

	begin

		/*LED_shift_right_checker : component LED_shift_right
			port map(
				clk => clk_tb,
				rst => rst_tb,
				led_reg => led_reg_tb
			);

		LED_shift_left_checker : component LED_shift_left_2
			port map(
				clk => clk_tb,
				rst => rst_tb,
				led_reg => led_reg_tb
			);

		LED_7bitUPcount_checker : component LED_7bitUPcount
			port map(
				clk => clk_tb,
				rst => rst_tb,
				led_reg => led_reg_tb
			);

		LED_7bitDOWNcount_checker : component LED_7bitDOWNcount
			port map(
				clk => clk_tb,
				rst => rst_tb,
				led_reg => led_reg_tb
			);*/

		LED_shiftINOUT_checker : component LED_shiftINOUT
			port map(
				clk => clk_tb,
				rst => rst_tb,
				led_reg => led_reg_tb
			);

		 clk_tb <= not clk_tb after 20 ns / 2;

		clk_checker	: process is
			begin
				wait for CLOCK_PERIOD*10;

		end process;

end architecture;

