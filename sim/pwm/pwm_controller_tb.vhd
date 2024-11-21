library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_controller_tb is
end entity;


architecture pwm_controller_tb_arch of pwm_controller_tb is

	component pwm_controller is
		generic(
			CLK_PERIOD : time := 20 ns
		);
		port(
			clk	: in std_logic;
			rst	: in std_logic;
			-- PWM repetition period in milliseconds;
			-- datatype (W.F) is individually assigned
			period	: in unsigned(23 downto 0);
			-- PWM duty cycle between [0,1]; out of range values are hard-limited
			-- datatype (W.F) is individually assigned
			duty_cycle 	: in unsigned(13 downto 0);
			output		: out std_logic
		);
	end component;

	signal clk_tb 		: std_logic := '0';
	signal rst_tb		: std_logic := '0';
	signal period_tb	: unsigned(23 downto 0)	:= "000000100000000000000000";	-- (24.18) W.F 0.5ms
	signal duty_cycle_tb	: unsigned(13 downto 0) := "01000000000000";	-- (14.13) W.F	50%
	signal output_tb	: std_logic := '1';

	constant CLK_PERIOD	: time := 20 ns;

	begin

	pwm_checker : component pwm_controller
		generic map(
			CLK_PERIOD => 20 ns
		)
		port map(
			clk	=> clk_tb,
			rst	=> rst_tb,
			period	=> period_tb,
			duty_cycle	=> duty_cycle_tb,
			output		=> output_tb
		);
	

	 clk_tb <= not clk_tb after 20 ns / 2;


end architecture;
