library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_patterns is
	generic(
		system_clock_period	: time := 20 ns
	);
	port(
		clk		: in std_logic;
		rst		: in std_logic;
		push_button	: in std_logic;
		switches	: in std_logic_vector(3 downto 0);
		hps_led_control	: in boolean;
		base_period	: in unsigned(7 downto 0);
		led_reg		: in std_logic_vector(7 downto 0);
		led		: out std_logic_vector(7 downto 0)
	);
end entity led_patterns;

architecture led_patterns_arch of led_patterns is

	constant SYS_CLK_FREQ : unsigned(25 downto 0) := (to_unsigned((1 sec / system_clock_period), 26));
	constant N_BITS_CLK_CYCLES_FULL : natural := 34; --26+8 or N_BITS_SYS_CLK_FREQ +8
	constant N_BITS_CLK_CYCLES : natural := 30; --26+4 or N_BITS_SYS_CLK_FREQ + 4

	-- number of clock cycles in one base period. This signal has the same number of fractional bits as base
	-- base_period, thus it can represent a fractional number of clock cycles
	signal period_base_clk_full_prec : unsigned(N_BITS_CLK_CYCLES_FULL - 1 downto 0); 
	-- number of clock cycles in one base_period. This signal will only represent an integer number of clock cycles
	signal period_base_clk : unsigned(N_BITS_CLK_CYCLES - 1 downto 0);


	signal LEDs0, LEDs1, LEDs2, LEDs3, LEDs4 : std_logic_vector(6 downto 0);

	component clkDiv
		port(
			clk	: in std_logic;
			rst	: in std_logic;
			base_period 	  : in unsigned(29 downto 0);
			half_clk_out 	  : out std_logic := '0';
			quarter_clk_out	  : out std_logic := '0';
			eighth_clk_out	  : out std_logic := '0';
			double_clk_out	  : out std_logic := '0';
			quadruple_clk_out : out std_logic := '0'
		);
	end component;


	component LED_shift_right
		port(
			clk		: in std_logic;
			rst		: in std_logic;
			led		: out std_logic_vector(6 downto 0)	
		);
	end component;

	component LED_7bitUPcount
		port(
			clk		: in std_logic;
			rst		: in std_logic;
			led		: out std_logic_vector(6 downto 0)	
		);
	end component;

	component LED_shift_left_2
		port(
			clk		: in std_logic;
			rst		: in std_logic;
			led		: out std_logic_vector(6 downto 0)	
		);
	end component;

	component LED_7bitDOWNcount
		port(
			clk		: in std_logic;
			rst		: in std_logic;
			led		: out std_logic_vector(6 downto 0)	
		);
	end component;
	
	component LED_shiftINOUT
		port(
			clk		: in std_logic;
			rst		: in std_logic;
			led		: out std_logic_vector(6 downto 0)	
		);
	end component;

	component timed_counter
		generic(
			clk_period : time;
			count_time : time
		);
		port(
			clk	: in std_logic;
			enable	: in boolean;
			done	: out boolean
		);
	end component;

	component async_conditioner is
		port(
			clk	: in std_logic;
			rst	: in std_logic;
			async	: in std_logic;
			sync	: out std_logic
		);
	end component;

	signal half_clk 	  : std_logic := '0';
	signal quarter_clk	  : std_logic := '0';
	signal eighth_clk	  : std_logic := '0';
	signal double_clk	  : std_logic := '0';
	signal quadruple_clk  	  : std_logic := '0';

	signal enableTime : boolean := false;
	signal secDone   : boolean := false;
	signal PB 	: std_logic := '0';
	signal baseRateLED : std_logic := '0';
	signal counter : integer range 0 to 268435455;

	type State_Type is (s0, s1, s2, s3, s4, waitState, softHat);
	signal current_state, next_state, previous_state : State_Type;

	begin
		period_base_clk_full_prec <= SYS_CLK_FREQ * base_period;
		period_base_clk <= period_base_clk_full_prec(N_BITS_CLK_CYCLES_FULL - 1 downto 4);
		
		clkGen : clkDiv
			port map(
				clk	=> clk,
				rst	=> rst,
				base_period 	  => period_base_clk,
				half_clk_out 	  => half_clk,
				quarter_clk_out	  => quarter_clk,
				eighth_clk_out	  => eighth_clk,
				double_clk_out	  => double_clk,
				quadruple_clk_out => quadruple_clk
			);
		

		LED_state0 : LED_shift_right
			port map(
				clk => half_clk,
				rst => rst,
				led => LEDs0
			);

		LED_state1 : LED_shift_left_2
			port map(
				clk => quarter_clk,
				rst => rst,
				led => LEDs1
			);

		LED_state2 : LED_7bitUPcount
			port map(
				clk => double_clk,
				rst => rst,
				led => LEDs2
			);
	
		LED_state3 : LED_7bitDOWNcount
			port map(
				clk => eighth_clk,
				rst => rst,
				led => LEDs3
			);

		LED_state4 : LED_shiftINOUT
			port map(
				clk => quadruple_clk,
				rst => rst,
				led => LEDs4
			);

		oneSecCounter : timed_counter
			generic map(
				clk_period => 20 ns,
				count_time => 1 sec
			)
			port map(
				clk 	=> clk,
				enable 	=> enableTime,
				done 	=> secDone
			);

		asyncConditioner : async_conditioner
			port map(
				clk	=> clk,
				rst	=> rst,
				async	=> push_button,
				sync	=> PB
			);
		-------------------------------------------------------------------
		STATE_MEMORY : process (clk, rst)
			begin
				if(rst = '1')then
					current_state <= s0;
				elsif (rising_edge(clk)) then
					if(hps_led_control) then
						current_state <= softHat;
					else
						current_state <= next_state;
					end if;
				end if;
		end process;
		-------------------------------------------------------------------
		NEXT_STATE_LOGIC : process (current_state, previous_state, PB, switches)
		begin
			if rst = '1' then
				next_state <= s0;
			elsif(PB = '1') then
				next_state <= waitState;
			else
				if secDone then
					case(switches) is
						when "0000" => next_state <= s0;
						when "0001" => next_state <= s1;
						when "0010" => next_state <= s2;
						when "0011" => next_state <= s3;
						when "0100" => next_state <= s4;
						when others => next_state <= previous_state;
					end case;
				end if;
			end if;
		end process;
		-------------------------------------------------------------------
		OUTPUT_LOGIC :	process(current_state, switches, enableTime)
		begin
			case(current_state) is
				when s0 => led(6 downto 0) <= LEDs0; enableTime <= false; previous_state <= current_state;
				when s1 => led(6 downto 0) <= LEDs1; enableTime <= false; previous_state <= current_state;
				when s2 => led(6 downto 0) <= LEDs2; enableTime <= false; previous_state <= current_state;
				when s3 => led(6 downto 0) <= LEDs3; enableTime <= false; previous_state <= current_state;
				when s4 => led(6 downto 0) <= LEDs4; enableTime <= false; previous_state <= current_state;
				when waitState => led(6 downto 4) <= "000"; led(3 downto 0) <= switches;
					enableTime <= true;
				when softHat => led(6 downto 0) <= led_reg(6 downto 0);
			end case;
		end process;

		LEDseven : process(clk, period_base_clk)
		begin
			if rising_edge(clk) then
				if counter = period_base_clk then
					counter <= 0;
					baseRateLED <= not baseRateLED;
				else
					counter<= counter+1;
				end if;
			end if;
			led(7) <= baseRateLED;
		end process;

end architecture;