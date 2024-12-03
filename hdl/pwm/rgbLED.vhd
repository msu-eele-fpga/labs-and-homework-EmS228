library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rgbLED is
	port(
		clk	: in std_logic;
		rst	: in std_logic;
		
		-- avalon memory-mapped slave interface
		avs_read 	: in std_logic;
		avs_write 	: in std_logic;
		avs_address 	: in std_logic_vector(1 downto 0);
		avs_readdata	: out std_logic_vector(31 downto 0);
		avs_writedata	: in std_logic_vector(31 downto 0);
		
		output_red		: out std_logic;
		output_green	: out std_logic;
		output_blue		: out std_logic
	);
end entity rgbLED;

architecture rgbLED_arch of rgbLED is

	constant TWENTY_NANO : time := 20 ns;
	signal period	: unsigned(31 downto 0)	:= "00000000000000100000000000000000";	-- (24.18) W.F 0.5ms
	signal duty_cycle_red	: unsigned(31 downto 0) := "00000000000000000000100000000000";	-- (14.13) W.F	25%
	signal duty_cycle_green	: unsigned(31 downto 0) := "00000000000000000000100000000000";	-- (14.13) W.F	25%
	signal duty_cycle_blue	: unsigned(31 downto 0) := "00000000000000000000100000000000";	-- (14.13) W.F	25%
	
	
	component pwm_controller is
		generic(
			CLK_PERIOD : time := 20 ns
		);
		port(
			clk	: in std_logic;
			rst	: in std_logic;
			period	: in unsigned(23 downto 0);
			duty_cycle 	: in unsigned(13 downto 0);
			output		: out std_logic
		);
	end component pwm_controller;
	
	begin
	
		pwm_red : component pwm_controller
			generic map(
				CLK_PERIOD => 20 ns
			)
			port map(
				clk	=> clk,
				rst	=> rst,
				period	=> period(23 downto 0),
				duty_cycle	=> duty_cycle_red(13 downto 0),
				output		=> output_red
			);
		
		pwm_green : component pwm_controller
			generic map(
				CLK_PERIOD => 20 ns
			)
			port map(
				clk	=> clk,
				rst	=> rst,
				period	=> period(23 downto 0),
				duty_cycle	=> duty_cycle_green(13 downto 0),
				output		=> output_green
			);
		
		pwm_blue : component pwm_controller
			generic map(
				CLK_PERIOD => 20 ns
			)
			port map(
				clk	=> clk,
				rst	=> rst,
				period	=> period(23 downto 0),
				duty_cycle	=> duty_cycle_blue(13 downto 0),
				output		=> output_blue
			);
	
		avalon_register_read : process(clk)
			begin
				if rising_edge(clk) and avs_read = '1' then
					case avs_address is
						when "00" => avs_readdata <= std_logic_vector(duty_cycle_red);
						when "01" => avs_readdata <= std_logic_vector(duty_cycle_green);
						when "10" => avs_readdata <= std_logic_vector(duty_cycle_blue);
						when "11" => avs_readdata <= std_logic_vector(period);
						when others => avs_readdata <= (others =>'0'); -- return zeros for unused registers
					end case;
				end if;
		end process;
	
		avalon_register_write : process(clk, rst)
			begin
				if rst = '1' then
					duty_cycle_red <= "00000000000000000000100000000000";				-- (14.13) W.F	25%
					duty_cycle_green <= "00000000000000000000100000000000";			-- (14.13) W.F	25%
					duty_cycle_blue <= "00000000000000000000100000000000";			-- (14.13) W.F	25%
					period			<= "00000000000000100000000000000000";-- (24.18) W.F 0.5ms
				elsif rising_edge(clk) and avs_write = '1' then
					case avs_address is
						when "00" => duty_cycle_red <= unsigned(avs_writedata(31 downto 0));
						when "01" => duty_cycle_green <= unsigned(avs_writedata(31 downto 0));
						when "10" => duty_cycle_blue <= unsigned(avs_writedata(31 downto 0));
						when "11" => period				<= unsigned(avs_writedata(31 downto 0));
						when others => null; -- ignore writes to unused registers
					end case;
				end if;
		end process;

end architecture;