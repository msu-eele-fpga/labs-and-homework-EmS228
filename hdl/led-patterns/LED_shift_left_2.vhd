library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LED_shift_left_2 is
	port(
		clk		: in std_logic;
		rst		: in std_logic;
		led		: out std_logic_vector(6 downto 0)	
	);
end entity;

architecture LED_shift_left_2_arch of LED_shift_left_2 is
	signal leds : std_logic_vector(6 downto 0) := "0000011";
begin

	left_shift_LEDs : process(clk, rst)
		begin
			if rising_edge(clk) then
				led(6 downto 0) <= leds(6 downto 0);
				leds <= std_logic_vector(shift_left(unsigned(leds), 1));
				if leds = "1100000" then
					leds <= "1000001";
				elsif leds = "1000001" then
					leds <= "0000011";
				end if;
			end if;

	end process left_shift_LEDs;

end architecture;
