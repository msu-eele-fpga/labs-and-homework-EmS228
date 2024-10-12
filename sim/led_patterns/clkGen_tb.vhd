library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clkGen_tb is
end entity;


architecture clkGen_tb_arch of clkGen_tb is

	component clkDiv is
		port(
			clk	: in std_ulogic;
			rst	: in std_ulogic;
			base_period 	  : in unsigned(29 downto 0);
			half_clk_out 	  : out std_ulogic := '0';
			quarter_clk_out	  : out std_ulogic := '0';
			eighth_clk_out	  : out std_ulogic := '0';
			double_clk_out	  : out std_ulogic := '0';
			quadruple_clk_out : out std_ulogic := '0'
		);
	end component;

	signal clk_tb 		: std_ulogic := '0';
	signal rst_tb		: std_ulogic := '0';
	signal base_period_tb	: unsigned(29 downto 0) := to_unsigned(16, 30);
	signal half_clk_out_tb	: std_ulogic := '0';
	signal quarter_clk_out_tb	: std_ulogic := '0';
	signal eighth_clk_out_tb	: std_ulogic := '0';
	signal double_clk_out_tb	: std_ulogic := '0';
	signal quadruple_clk_out_tb : std_ulogic := '0';

	begin

	half_clkGen_checker : component clkDiv
			port map(
				clk	=> clk_tb,
				rst	=> rst_tb,
				base_period 	  => base_period_tb,
				half_clk_out 	  => half_clk_out_tb,
				quarter_clk_out	  => quarter_clk_out_tb,
				eighth_clk_out	  => eighth_clk_out_tb,
				double_clk_out	  => double_clk_out_tb,
				quadruple_clk_out => quadruple_clk_out_tb
			);


	
	 clk_tb <= not clk_tb after 20 ns / 2;


end architecture;