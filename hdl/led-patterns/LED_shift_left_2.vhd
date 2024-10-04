library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LED_shift_left_2 is
	port(
		clk		: in std_ulogic;
		rst		: in std_ulogic;
		led_reg		: in std_ulogic_vector(7 downto 0);
		led		: out std_ulogic_vector(7 downto 0)	
	);
end entity;

architecture LED_shift_left_2_arch of LED_shift_left_2 is
	signal leds : std_ulogic_vector(7 downto 0) := "00000011";
begin

	right_shift_LEDs : process(clk, rst)
		begin
			if rising_edge(clk) then
				led(7 downto 0) <= leds(7 downto 0);
				leds <= std_ulogic_vector(shift_left(unsigned(leds), 1));
				if leds = "11000000" then
					leds <= "10000001";
				elsif leds = "10000001" then
					leds <= "00000011";
				end if;
			end if;

	end process right_shift_LEDs;

end architecture;
