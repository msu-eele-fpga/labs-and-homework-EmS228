library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clkDiv is
	port(
		clk	: in std_logic;
		rst	: in std_logic;
		base_period 	  : in unsigned(29 downto 0);
		half_clk_out 	  : out std_logic := '0';
		quarter_clk_out	: out std_logic := '0';
		eighth_clk_out	  : out std_logic := '0';
		double_clk_out	  : out std_logic := '0';
		quadruple_clk_out : out std_logic := '0'
	);
end entity;

architecture clkDiv_arch of clkDiv is

	signal quadruple_period : unsigned(29 downto 0);
	signal double_period : unsigned(29 downto 0);
	signal half_period : unsigned(29 downto 0);
	signal quarter_period : unsigned(29 downto 0);
	signal eighth_period : unsigned(29 downto 0);
	
	signal half_clk : std_logic := '0';
	signal quarter_clk : std_logic := '0';
	signal eighth_clk : std_logic := '0';
	signal quadruple_clk : std_logic := '0';
	signal double_clk : std_logic := '0';

	signal clk_time_quadruple : unsigned(29 downto 0)      := (others => '0');
	signal clk_time_double : unsigned(29 downto 0)      := (others => '0');
	signal clk_time_half : unsigned(29 downto 0)      := (others => '0');
	signal clk_time_quarter : unsigned(29 downto 0)   := (others => '0');
	signal clk_time_eighth : unsigned(29 downto 0)   := (others => '0');

	begin

		------------------------------half-period------------------------------
		half_period <= shift_right(base_period, 1);

		half_clkGen	: process(clk, rst)
			begin
			if rising_edge(clk) then
				if (rst = '1') then
					clk_time_half <= (others => '0');
				else 
					if clk_time_half < (half_period) then
						clk_time_half <= clk_time_half + 1;
					else
						half_clk <= not half_clk;
						half_clk_out <= half_clk;
						clk_time_half <= (others => '0');
					end if;
				end if;
			end if;

		end process half_clkGen;
		-----------------------------------------------------------------------

		----------------------------quarter-period-----------------------------
		quarter_period <= shift_right(half_period, 1);

		quarter_clkGen	: process(clk, rst)
			begin
			if rising_edge(clk) then
				if (rst = '1') then
					clk_time_quarter <= (others => '0');
				else 
					if clk_time_quarter < (quarter_period) then
						clk_time_quarter <= clk_time_quarter + 1;
					else
						quarter_clk <= not quarter_clk;
						quarter_clk_out <= quarter_clk;
						clk_time_quarter <= (others => '0');
					end if;
				end if;
			end if;

		end process quarter_clkGen;
		-----------------------------------------------------------------------

		-----------------------------eighth-period-----------------------------
		eighth_period <= shift_right(half_period, 2);

		eighth_clkGen	: process(clk, rst)
			begin
			if rising_edge(clk) then
				if (rst = '1') then
					clk_time_eighth <= (others => '0');
				else 
					if clk_time_eighth < (eighth_period) then
						clk_time_eighth <= clk_time_eighth + 1;
					else
						eighth_clk <= not eighth_clk;
						eighth_clk_out <= eighth_clk;
						clk_time_eighth <= (others => '0');
					end if;
				end if;
			end if;

		end process eighth_clkGen;
		-----------------------------------------------------------------------

		-----------------------------double-period-----------------------------
		double_period <= shift_left(base_period, 1);

		double_clkGen	: process(clk, rst)
			begin
			if rising_edge(clk) then
				if (rst = '1') then
					clk_time_double <= (others => '0');
				else 
					if clk_time_double < (double_period) then
						clk_time_double <= clk_time_double + 1;
					else
						double_clk <= not double_clk;
						double_clk_out <= double_clk;
						clk_time_double <= (others => '0');
					end if;
				end if;
			end if;

		end process double_clkGen;
		-----------------------------------------------------------------------

		---------------------------quadruple-period----------------------------
		quadruple_period <= shift_left(base_period, 2);

		quadruple_clkGen	: process(clk, rst)
			begin
			if rising_edge(clk) then
				if (rst = '1') then
					clk_time_quadruple <= (others => '0');
				else 
					if clk_time_quadruple < (quadruple_period) then
						clk_time_quadruple <= clk_time_quadruple + 1;
					else
						quadruple_clk <= not quadruple_clk;
						quadruple_clk_out <= quadruple_clk;
						clk_time_quadruple <= (others => '0');
					end if;
				end if;
			end if;

		end process quadruple_clkGen;
		-----------------------------------------------------------------------


end architecture;