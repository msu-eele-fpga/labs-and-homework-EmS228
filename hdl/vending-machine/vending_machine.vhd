library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity vending_machine is
	port(
		clk 	: in std_ulogic;
		rst	: in std_ulogic;
		nickel	: in std_ulogic;
		dime	: in std_ulogic;
		dispense: out std_ulogic;
		amount	: out natural range 0 to 15
	);
end entity vending_machine;

architecture vending_machine_arch of vending_machine is

	type State_Type is (s0, s5, s10, s15);
	signal current_state, next_state : State_Type;

	begin

-------------------------------------------------------------------
	STATE_MEMORY : process (clk, rst)
		begin
			if(rst = '1')then
				current_state <= s0;
			elsif (rising_edge(clk)) then
				current_state <= next_state;
			end if;
	end process;
-------------------------------------------------------------------
	NEXT_STATE_LOGIC : process (current_state, nickel, dime)
		begin
			case(current_state) is
				when s0 => if (nickel = '1')  and (dime = '1') then
						next_state <= s10;
					   elsif (nickel = '1') then
						next_state <= s5;
					   elsif (dime = '1') then
						next_state <= s10;
					   else
						next_state <= s0;
					   end if;
				when s5 => if (nickel = '1')  and (dime = '1') then
						next_state <= s15;
					   elsif (dime = '1') then
						next_state <= s15;
					   elsif (nickel = '1') then
						next_state <= s10;
					   else 
						next_state <= s5;
					   end if;
				when s10 => if (nickel = '1')  and (dime = '1') then
						next_state <= s15;
					    elsif (dime = '1') then
						next_state <= s15;
					    elsif (nickel = '1') then
						next_state <= s15;
					    else
						next_state <= s10;
					    end if;
				when others => next_state <= s0;
			end case;
	end process;
-------------------------------------------------------------------
	OUTPUT_LOGIC :	process(current_state, nickel, dime)
		begin
			case(current_state) is
				when s0 => dispense <= '0';  amount <= 0;
				when s5 => dispense <= '0';  amount <= 5;
				when s10 => dispense <= '0'; amount <= 10;
				when s15 => dispense <= '1'; amount <= 15;
				when others => dispense <= '0'; amount <= 0;
			end case;
	end process;

end architecture;
