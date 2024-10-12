library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity async_conditioner is
	port(
		clk	: in std_logic;
		rst	: in std_logic;
		async	: in std_logic;
		sync	: out std_logic
	);
end entity async_conditioner;

architecture async_conditioner_arch of async_conditioner is

	component debouncer
		generic(
			clk_period	: time := 20 ns;
			debounce_time	: time := 200 ns
		);
		port(
			clk		: in std_logic;
			rst		: in std_logic;
			input		: in std_logic;
			debounced	: out std_logic
		);
	end component;

	component one_pulse
		port(
			clk	: in std_logic;
			rst	: in std_logic;
			input	: in std_logic;
			pulse	: out std_logic
		);
	end component;

	component synchronizer
		port (
    			clk : in std_logic;
    			async : in std_logic;
    			sync : out std_logic
		);
	end component;

	signal sync_out	     : std_logic := '0';
	signal debounced_out : std_logic := '0';

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
