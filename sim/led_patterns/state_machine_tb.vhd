library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity state_machine_tb is
end entity;


architecture state_machine_tb_arch of state_machine_tb is
	component led_patterns is
		generic(
			system_clock_period	: time := 20 ns
		);
		port(
			clk		: in std_ulogic;
			rst		: in std_ulogic;
			push_button	: in std_ulogic;
			switches	: in std_ulogic_vector(3 downto 0);
			hps_led_control	: in boolean;
			base_period	: in unsigned(7 downto 0);
			led_reg		: in std_ulogic_vector(7 downto 0);
			led		: out std_ulogic_vector(7 downto 0)
		);
	end component led_patterns;

	constant TWENTY_NANO	: time := 20 ns;
	constant CLOCK_PERIOD	: time := 20 ns;
	signal clk_tb 		: std_ulogic := '0';
	signal rst_tb		: std_ulogic := '0';
	signal push_button_tb	: std_ulogic := '0';
	signal switches_tb	: std_ulogic_vector(3 downto 0) := "0000";
	signal hps_led_control_tb	: boolean := false;
	signal base_period_tb	: unsigned(7 downto 0) := "00001000";
	signal led_reg_tb	: std_ulogic_vector(7 downto 0);
	signal led_tb		: std_ulogic_vector(7 downto 0) := "00000000";

	begin

		state_machine_checker : component led_patterns
			generic map(
				system_clock_period => TWENTY_NANO
			)
			port map(
				clk		=> clk_tb,
				rst		=> rst_tb,
				push_button	=> push_button_tb,
				switches	=> switches_tb,
				hps_led_control	=> hps_led_control_tb,
				base_period	=> base_period_tb,
				led_reg		=> led_reg_tb,
				led		=> led_tb
			);
		checker	: process is
			begin
				wait for CLOCK_PERIOD*2;
				push_button_tb <= '1';

				wait for CLOCK_PERIOD*3;
				push_button_tb <= '0';

				wait for CLOCK_PERIOD*4;
				switches_tb <= "0000";
				wait for CLOCK_PERIOD*20;

				wait for CLOCK_PERIOD*4;
				switches_tb <= "0010";

				wait for CLOCK_PERIOD*1;
				push_button_tb <= '1';

				wait for CLOCK_PERIOD*3;
				push_button_tb <= '0';

				wait for CLOCK_PERIOD*100;

		end process checker;

		
		 clk_tb <= not clk_tb after 20 ns / 2;


end architecture;
