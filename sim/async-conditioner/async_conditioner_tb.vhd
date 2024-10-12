library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity async_conditioner_tb is
end entity async_conditioner_tb;


architecture testbench of async_conditioner_tb is
	component async_conditioner is
		port(
			clk	: in std_ulogic;
			rst	: in std_ulogic;
			async	: in std_ulogic;
			sync	: out std_ulogic
		);
	end component async_conditioner;

	signal clk_tb 	: std_ulogic := '0';
	signal rst_tb	: std_ulogic := '0';
	signal input_tb	: std_ulogic := '0';
	signal sync_tb : std_ulogic := '0';
	signal sync_expected : std_ulogic := '0';

	constant CLOCK_PERIOD	: time := 20 ns;

	begin
		dut_async_check : component async_conditioner
			port map(
				clk => clk_tb,
				rst => rst_tb,
				async => input_tb,
				sync => sync_tb
			);

		 clk_tb <= not clk_tb after 20 ns / 2;

		input_wav : process is
			begin

				wait for CLOCK_PERIOD*2;
				rst_tb <= '1';

				wait for CLOCK_PERIOD*1;
				rst_tb <= '0';				

				wait for CLOCK_PERIOD*2.2;
				input_tb <= '1';

				wait for CLOCK_PERIOD*4;
				input_tb <= '0';

				wait for CLOCK_PERIOD*3;
				input_tb <= '1';

				wait for CLOCK_PERIOD*5;
				input_tb <= '0';

				wait for CLOCK_PERIOD*1;
				input_tb <= '1';

				wait for CLOCK_PERIOD*0.75;
				input_tb <= '0';

				wait for CLOCK_PERIOD*4;
				input_tb <= '1';
			
				wait for CLOCK_PERIOD*3;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*2;
				input_tb <= '1';

				wait for CLOCK_PERIOD*1;
				input_tb <= '0';

				wait for CLOCK_PERIOD*6;
				input_tb <= '1';

				wait for CLOCK_PERIOD*3;
				input_tb <= '0';

				wait for CLOCK_PERIOD*1;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';

				wait for CLOCK_PERIOD*6;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*7;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';

				wait for CLOCK_PERIOD*2;
				input_tb <= '1';

				wait for CLOCK_PERIOD*5;
				input_tb <= '0';

				wait for CLOCK_PERIOD*10;
				input_tb <= '1';

				wait for CLOCK_PERIOD*4;
				input_tb <= '0';

				wait for CLOCK_PERIOD*50;
				input_tb <= '1';

				wait for CLOCK_PERIOD*4;
				input_tb <= '0';

				wait for CLOCK_PERIOD*3;
				input_tb <= '1';

				wait for CLOCK_PERIOD*5;
				input_tb <= '0';

				wait for CLOCK_PERIOD*1;
				input_tb <= '1';

				wait for CLOCK_PERIOD*0.75;
				input_tb <= '0';

				wait for CLOCK_PERIOD*4;
				input_tb <= '1';
			
				wait for CLOCK_PERIOD*3;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*2;
				input_tb <= '1';

				wait for CLOCK_PERIOD*1;
				input_tb <= '0';

				wait for CLOCK_PERIOD*6;
				input_tb <= '1';

				wait for CLOCK_PERIOD*3;
				input_tb <= '0';

				wait for CLOCK_PERIOD*1;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';

				wait for CLOCK_PERIOD*6;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*7;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';

				wait for CLOCK_PERIOD*2;
				input_tb <= '1';

				wait for CLOCK_PERIOD*5;
				input_tb <= '0';

				wait for CLOCK_PERIOD*10;
				input_tb <= '1';

				wait for CLOCK_PERIOD*4;
				input_tb <= '0';

				wait for CLOCK_PERIOD*100;
				input_tb <= '1';

				wait for CLOCK_PERIOD*4;
				input_tb <= '0';

				wait for CLOCK_PERIOD*3;
				input_tb <= '1';

				wait for CLOCK_PERIOD*5;
				input_tb <= '0';

				wait for CLOCK_PERIOD*1;
				input_tb <= '1';

				wait for CLOCK_PERIOD*0.75;
				input_tb <= '0';

				wait for CLOCK_PERIOD*4;
				input_tb <= '1';
			
				wait for CLOCK_PERIOD*3;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*2;
				input_tb <= '1';

				wait for CLOCK_PERIOD*1;
				input_tb <= '0';

				wait for CLOCK_PERIOD*6;
				input_tb <= '1';

				wait for CLOCK_PERIOD*3;
				input_tb <= '0';

				wait for CLOCK_PERIOD*1;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';

				wait for CLOCK_PERIOD*6;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*7;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';

				wait for CLOCK_PERIOD*2;
				input_tb <= '1';

				wait for CLOCK_PERIOD*5;
				input_tb <= '0';

				wait for CLOCK_PERIOD*10;
				input_tb <= '1';

				wait for CLOCK_PERIOD*4;
				input_tb <= '0';

				wait for CLOCK_PERIOD*50;
				input_tb <= '1';

				wait for CLOCK_PERIOD*4;
				input_tb <= '0';

				wait for CLOCK_PERIOD*3;
				input_tb <= '1';

				wait for CLOCK_PERIOD*5;
				input_tb <= '0';

				wait for CLOCK_PERIOD*1;
				input_tb <= '1';

				wait for CLOCK_PERIOD*0.75;
				input_tb <= '0';

				wait for CLOCK_PERIOD*4;
				input_tb <= '1';
			
				wait for CLOCK_PERIOD*3;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*2;
				input_tb <= '1';

				wait for CLOCK_PERIOD*1;
				input_tb <= '0';

				wait for CLOCK_PERIOD*6;
				input_tb <= '1';

				wait for CLOCK_PERIOD*3;
				input_tb <= '0';

				wait for CLOCK_PERIOD*1;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';

				wait for CLOCK_PERIOD*6;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';
			
				wait for CLOCK_PERIOD*7;
				input_tb <= '1';

				wait for CLOCK_PERIOD*2;
				input_tb <= '0';

				wait for CLOCK_PERIOD*2;
				input_tb <= '1';

				wait for CLOCK_PERIOD*5;
				input_tb <= '0';

				wait for CLOCK_PERIOD*10;
				input_tb <= '1';

				wait for CLOCK_PERIOD*4;
				input_tb <= '0';

		end process;


		stimuli_and_checker : process is
			begin
		-----------------------------------------test case 1-----------------------------------------
				wait for CLOCK_PERIOD*2.5;
				sync_expected <= '1';
				wait for CLOCK_PERIOD;
				sync_expected <= '0';
				wait for CLOCK_PERIOD*2;
				assert_eq(sync_tb, sync_expected, "test failed: pulse is not correct");

				wait for CLOCK_PERIOD*6;
				sync_expected <= '1';
				wait for CLOCK_PERIOD;
				sync_expected <= '0';
				wait for CLOCK_PERIOD*1;
				assert_eq(sync_tb, sync_expected, "test failed: pulse is not correct");

				wait for CLOCK_PERIOD*7;
				sync_expected <= '1';
				wait for CLOCK_PERIOD;
				sync_expected <= '0';
				wait for CLOCK_PERIOD*3;
				assert_eq(sync_tb, sync_expected, "test failed: pulse is not correct");

				wait for CLOCK_PERIOD*300;

			std.env.finish;
		end process stimuli_and_checker;
end architecture;
