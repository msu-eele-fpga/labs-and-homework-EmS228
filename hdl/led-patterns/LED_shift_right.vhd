library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LED_shift_right is
	port(
		clk		: in std_logic;
		rst		: in std_logic;
		led		: out std_logic_vector(6 downto 0)	
	);
end entity;

architecture LED_shift_right_arch of LED_shift_right is
	signal leds : std_logic_vector(6 downto 0) := "1000000";
begin

	right_shift_LEDs : process(clk, rst, leds)
		begin
			if rising_edge(clk) then
				led(6 downto 0) <= leds(6 downto 0);
				leds <= std_logic_vector(shift_right(unsigned(leds), 1));
				if leds = "0000001" then
					leds <= "1000000";
				end if;
			end if;

	end process right_shift_LEDs;

end architecture;
