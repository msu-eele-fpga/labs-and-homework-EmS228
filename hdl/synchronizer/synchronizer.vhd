library IEEE;
use IEEE.std_logic_1164.all;

entity synchronizer is
	port (
    		clk : in std_logic;
    		async : in std_logic;
    		sync : out std_logic
	);
end entity synchronizer;

architecture synchronizer_arch of synchronizer is

	  signal output : std_logic;

	begin
		D_FLIP_FLOP_1 : process(clk)
			begin
				if rising_edge(clk) then
					output <= async;
				end if;
		end process;

		D_FLIP_FLOP_2 : process(clk)
			begin
				if rising_edge(clk) then
					sync <= output;
				end if;
		end process;

end architecture;
