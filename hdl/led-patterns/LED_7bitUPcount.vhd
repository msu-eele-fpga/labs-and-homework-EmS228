library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LED_7bitUPcount is
	port(
		clk	: in std_ulogic;
		rst	: in std_ulogic;
		led_reg : in std_ulogic_vector(7 downto 0);
		led	: out std_ulogic_vector(7 downto 0)
	);
end entity;

architecture LED_7bitUPcount_arch of LED_7bitUPcount is
	signal count : integer := 0;
	signal leds  : std_ulogic_vector(7 downto 0) := "00000000";
begin

	bit7_UPcount_LEDs : process(clk, rst)
		begin
			if rising_edge(clk) then
				led <= std_ulogic_vector(to_unsigned( count, led'length));
				count <= count + 1;

				if count = 255 then
					count <= 0;
				end if;
			end if;

	end process bit7_UPcount_LEDs;

end architecture;