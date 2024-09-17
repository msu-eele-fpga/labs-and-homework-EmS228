library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity async_conditioner is
	port(
		clk	: in std_ulogic;
		rst	: in std_ulogic;
		async	: in std_ulogic;
		sync	: out std_ulogic
	);
end entity async_conditioner;

architecture async_conditioner_arch of async_conditioner is

	component debouncer
		generic(
			clk_period	: time := 20 ns;
			debounce_time	: time := 200 ns
		);
		port(
			clk		: in std_ulogic;
			rst		: in std_ulogic;
			input		: in std_ulogic;
			debounced	: out std_ulogic
		);
	end component;

	component one_pulse
		port(
			clk	: in std_ulogic;
			rst	: in std_ulogic;
			input	: in std_ulogic;
			pulse	: out std_ulogic
		);
	end component;

	component synchronizer
		port (
    			clk : in std_ulogic;
    			async : in std_ulogic;
    			sync : out std_ulogic
		);
	end component;

	signal sync_out	     : std_ulogic := '0';
	signal debounced_out : std_ulogic := '0';

	begin

	SY : synchronizer
		port map(
    			clk 		=> clk,
    			async 		=> async,
    			sync		=> sync_out
		);

	DB : debouncer
		port map(
			clk		=>  clk,
			rst		=> rst,
			input		=> sync_out,
			debounced	=> debounced_out
		);

	OP : one_pulse
		port map(
			clk		=>  clk,
			rst		=> rst,
			input		=> debounced_out,
			pulse		=> sync
		);

			
end architecture;
