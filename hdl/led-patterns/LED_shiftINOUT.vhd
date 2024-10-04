library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LED_shiftINOUT is
	port(
		clk		: in std_ulogic;
		rst		: in std_ulogic;
		led_reg		: in std_ulogic_vector(7 downto 0);
		led		: out std_ulogic_vector(7 downto 0)
	);
end entity;

architecture LED_shiftINOUT_arch of LED_shiftINOUT is
	signal leds_upper : std_ulogic_vector(3 downto 0) := "0001";
	signal leds_lower : std_ulogic_vector(3 downto 0) := "1000";
begin

	INOUT_shift_LEDs : process(clk, rst)
		begin
			if rising_edge(clk) then
				led(7 downto 4) <= leds_upper;
				led(3 downto 0) <= leds_lower;
				leds_lower <= std_ulogic_vector(shift_right(unsigned(leds_lower), 1));
				leds_upper <= std_ulogic_vector(shift_left(unsigned(leds_upper), 1));
				if leds_lower = "0001" then
					leds_lower <= "1000";
				end if;
				if leds_upper = "1000" then
					leds_upper <= "0001";
				end if;
			end if;

	end process INOUT_shift_LEDs;

end architecture;
