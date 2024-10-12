library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LED_7bitDOWNcount is
	port(
		clk	: in std_logic;
		rst	: in std_logic;
		led	: out std_logic_vector(6 downto 0)
	);
end entity;

architecture LED_7bitDOWNcount_arch of LED_7bitDOWNcount is
	signal count : integer := 127;
begin

	bit7_DOWNcount_LEDs : process(clk, rst)
		begin
			if rising_edge(clk) then
				led <= std_logic_vector(to_unsigned( count, led'length));
				count <= count - 1;

				if count = 0 then
					count <= 127;
				end if;
			end if;

	end process bit7_DOWNcount_LEDs;

end architecture;
