library IEEE;
use IEEE.std_logic_1164.all;

entity debouncer is
	generic(
		clk_period	: time := 20 ns;
		debounce_time	: time := 100 ms
	);
	port(
		clk		: in std_ulogic;
		rst		: in std_ulogic;
		input		: in std_ulogic;
		debounced	: out std_ulogic
	);
end entity debouncer;

architecture debouncer_arch of debouncer is

	signal previous : std_ulogic := 'U';
	signal stop 	: natural := ((debounce_time/clk_period) - 1);
	signal counter  : natural := 0;		

	begin
		debouncer : process(clk, input, rst)
			begin
				if (rst = '1') then
					debounced <= '0';
					counter <= 0;
					previous <= '0';
				else
					if (rising_edge(clk)) then
						if (counter = 0) then
							if (input = '1' and previous = '0') then
								debounced <= '1';
								previous <= '1';
								counter <= counter + 1;
							elsif (input = '0' and previous = '1') then 
								debounced <= '0';
								previous <= '0';
								counter <= counter + 1;
							elsif (input = '0' and previous = 'U') then
								debounced <= '0';
								previous <= '0';
							end if;
						elsif (counter = stop) then
							counter <= 0;
						else
							counter <= counter + 1;
						end if;
					end if;
				end if;
		end process;
					



end architecture;