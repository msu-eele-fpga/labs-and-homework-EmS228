library ieee;
use ieee.std_logic_1164.all;

entity timed_counter is
	generic(
		clk_period : time;
		count_time : time
	);
	port(
		clk	: in std_logic;
		enable	: in boolean;
		done	: out boolean
	);
end entity timed_counter;

architecture timed_counter_arch of timed_counter is

	constant COUNTER_LIMIT : integer  := count_time/clk_period;
	signal clk_time : integer range 0 to COUNTER_LIMIT := 0;

	begin

		counter : process(enable, clk)
			begin
				if rising_edge(clk) then
					if enable then
						if clk_time < (COUNTER_LIMIT) then
							done <= false;
							clk_time <= clk_time + 1;
						else
							done <= true;
							clk_time <= 0;
						end if;
					else
						done <= false;
					end if;
				end if;
		end process;
		
end architecture timed_counter_arch;
