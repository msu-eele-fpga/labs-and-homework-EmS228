library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LED_7bitUPcount is
	port(
		clk	: in std_logic;
		rst	: in std_logic;
		led	: out std_logic_vector(6 downto 0)
	);
end entity;

architecture LED_7bitUPcount_arch of LED_7bitUPcount is
	signal count : integer := 0;
	signal leds  : std_logic_vector(6 downto 0) := "0000000";
begin

	bit7_UPcount_LEDs : process(clk, rst)
		begin
			if rising_edge(clk) then
				led <= std_logic_vector(to_unsigned( count, led'length));
				count <= count + 1;

				if count = 255 then
					count <= 0;
				end if;
			end if;

	end process bit7_UPcount_LEDs;

end architecture;