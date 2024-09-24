library ieee;
use ieee.std_logic_1164.all;

entity one_pulse is
		port(
			clk	: in std_ulogic;
			rst	: in std_ulogic;
			input	: in std_ulogic;
			pulse	: out std_ulogic
		);
end entity one_pulse;


architecture one_pulse_arch of one_pulse is

	signal clock_pulse : std_ulogic := '1';

	begin
	
		one_pulse : process(rst, clk, input)
			begin
				if(rst = '1') then
					pulse <= '0';
				else 
					if rising_edge(clk) then
						if (input = '1' and clock_pulse = '1') then
							pulse <= '1';
							clock_pulse <= '0';
						elsif (input = '0' and clock_pulse = '0') then
							clock_pulse <= '1';
						else
							pulse <= '0';
						end if;
					end if;
				end if;
		end process;


end architecture;