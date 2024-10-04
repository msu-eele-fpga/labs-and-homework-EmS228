library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LED_shift_right is
	port(
		clk		: in std_ulogic;
		rst		: in std_ulogic;
		led_reg		: in std_ulogic_vector(7 downto 0);
		led		: out std_ulogic_vector(7 downto 0)	
	);
end entity;

architecture LED_shift_right_arch of LED_shift_right is
	signal leds : std_ulogic_vector(7 downto 0) := "10000000";
begin

	right_shift_LEDs : process(clk, rst, leds)
		begin
			if rising_edge(clk) then
				led(7 downto 0) <= leds(7 downto 0);
				leds <= std_ulogic_vector(shift_right(unsigned(leds), 1));
				if leds = "00000001" then
					leds <= "10000000";
				end if;
			end if;

	end process right_shift_LEDs;

end architecture;
