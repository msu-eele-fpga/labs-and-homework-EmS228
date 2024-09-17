library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity one_pulse_tb is
end entity one_pulse_tb;

architecture testbench of one_pulse_tb is

	component one_pulse is
		port(
			clk	: in std_ulogic;
			rst	: in std_ulogic;
			input	: in std_ulogic;
			pulse	: out std_ulogic
		);
	end component one_pulse;

	signal clk_tb 	: std_ulogic := '0';
	signal rst_tb	: std_ulogic := '0';
	signal input_tb	: std_ulogic := '0';
	signal pulse_tb : std_ulogic := '0';
	signal pulse_expected : std_ulogic := '0';

	constant HUNDRED_NS	: time := 100 ns;
	constant CLOCK_PERIOD	: time := 20 ns;

	begin
		dut_one_pulse_check : component one_pulse
			port map(
				clk => clk_tb,
				rst => rst_tb,
				input => input_tb,
				pulse => pulse_tb
			);

		 clk_tb <= not clk_tb after 20 ns / 2;

		input_wav : process is
			begin
				wait for CLOCK_PERIOD*2;
				input_tb <= '1';
			
				wait for CLOCK_PERIOD*3;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*6;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*7;
				input_tb <= '1';

				wait for CLOCK_PERIOD*4;
				input_tb <= '0';

		end process;


		stimuli_and_checker : process is
			begin
		-----------------------------------------test case 1-----------------------------------------
				wait for CLOCK_PERIOD*2.5;
				pulse_expected <= '1';
				wait for CLOCK_PERIOD;
				pulse_expected <= '0';
				wait for CLOCK_PERIOD*2;
				assert_eq(pulse_tb, pulse_expected, "test failed: pulse is not correct");

				wait for CLOCK_PERIOD*6;
				pulse_expected <= '1';
				wait for CLOCK_PERIOD;
				pulse_expected <= '0';
				wait for CLOCK_PERIOD*1;
				assert_eq(pulse_tb, pulse_expected, "test failed: pulse is not correct");

				wait for CLOCK_PERIOD*7;
				pulse_expected <= '1';
				wait for CLOCK_PERIOD;
				pulse_expected <= '0';
				wait for CLOCK_PERIOD*3;
				assert_eq(pulse_tb, pulse_expected, "test failed: pulse is not correct");

			std.env.finish;
		end process stimuli_and_checker;

end architecture;