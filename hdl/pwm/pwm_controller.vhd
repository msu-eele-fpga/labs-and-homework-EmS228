library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_controller is
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
end entity pwm_controller;

architecture pwm_controller_arch of pwm_controller is

	------------------------------------- Period --------------------------------------
	constant SYS_CLK_FREQ : unsigned(25 downto 0) := (to_unsigned((1 ms / CLK_PERIOD), 26));

	-- number of clock cycles in one base period. This signal has the same number of fractional bits as base
	-- base_period, thus it can represent a fractional number of clock cycles
	signal period_base_clk_full_prec : unsigned(49 downto 0); -- 50 bits 26 + 24
	-- number of clock cycles in one base_period. This signal will only represent an integer number of clock cycles
	signal period_base_clk : unsigned(31 downto 0);	-- 26 + 6 number of integer bits

	-- counter
	signal counter : unsigned(49 downto 0) := (others => '0'); 
	signal pwm_sig	: std_logic := '1';
	
	-- duty cycle stuff
	signal percentDutyCycle : unsigned(63 downto 0); --50 + 14 (full prec + duty cycle)
	signal dutyCycle	: unsigned(32 downto 0); -- period base clk + 1 (duty cycle)

	begin

		period_base_clk_full_prec <= SYS_CLK_FREQ * period;
		period_base_clk <= period_base_clk_full_prec(49 downto 18);

		percentDutyCycle <= period_base_clk_full_prec * duty_cycle;
		dutyCycle	<= percentDutyCycle(63 downto 31);

		pwm : process(clk, rst)
			begin
			if rising_edge(clk) then
				if (rst = '1') then
					counter <= (others => '0');
					pwm_sig <= '0';
				else 
					if counter < (period_base_clk) then
						counter <= counter + 1;
						if counter = dutyCycle then
							pwm_sig <= '0';
						end if;
					else
						pwm_sig <= '1';
						counter <= (others => '0');
					end if;
				end if;
				output <= pwm_sig;
			end if;

		end process pwm;
end architecture;

