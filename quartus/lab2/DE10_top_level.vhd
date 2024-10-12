-- SPDX-License-Identifier: MIT
-- Copyright (c) 2017 Ross K. Snider.  All rights reserved.
----------------------------------------------------------------------------
-- Description:  Top level VHDL file for the DE10-Nano
----------------------------------------------------------------------------
-- Author:       Ross K. Snider
-- Company:      Montana State University
-- Create Date:  September 1, 2017
-- Revision:     1.0
-- License: MIT  (opensource.org/licenses/MIT)
----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

LIBRARY altera;
USE altera.altera_primitives_components.all;

-----------------------------------------------------------
-- Signal Names are defined in the DE10-Nano User Manual
-- http://de10-nano.terasic.com
-----------------------------------------------------------
 entity DE10_Top_Level is
	port(
	----------------------------------------
    --  Clock inputs
    --  See DE10 Nano User Manual page 23
    ----------------------------------------
    --! 50 MHz clock input #1
    fpga_clk1_50 : in    std_logic;
    --! 50 MHz clock input #2
    fpga_clk2_50 : in    std_logic;
    --! 50 MHz clock input #3
    fpga_clk3_50 : in    std_logic;

    ----------------------------------------
    --  Push button inputs (KEY)
    --  See DE10 Nano User Manual page 24
    --  The KEY push button inputs produce a '0'
    --  when pressed (asserted)
    --  and produce a '1' in the rest (non-pushed) state
    ----------------------------------------
    push_button_n : in    std_logic_vector(1 downto 0);

    ----------------------------------------
    --  Slide switch inputs (SW)
    --  See DE10 Nano User Manual page 25
    --  The slide switches produce a '0' when
    --  in the down position
    --  (towards the edge of the board)
    ----------------------------------------
    sw : in    std_logic_vector(3 downto 0);

    ----------------------------------------
    --  LED outputs
    --  See DE10 Nano User Manual page 26
    --  Setting LED to 1 will turn it on
    ----------------------------------------
    led : out   std_logic_vector(7 downto 0);

    ----------------------------------------
    --  GPIO expansion headers (40-pin)
    --  See DE10 Nano User Manual page 27
    --  Pin 11 = 5V supply (1A max)
    --  Pin 29 - 3.3 supply (1.5A max)
    --  Pins 12, 30 GND
    ----------------------------------------
    gpio_0 : inout std_logic_vector(35 downto 0);
    gpio_1 : inout std_logic_vector(35 downto 0);

    ----------------------------------------
    --  Arudino headers
    --  See DE10 Nano User Manual page 30
    ----------------------------------------
    arduino_io      : inout std_logic_vector(15 downto 0);
    arduino_reset_n : inout std_logic
  );
end entity DE10_Top_Level;



architecture DE10Nano_arch of DE10_Top_Level is

	component led_patterns is
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
	end component led_patterns;
	
	constant TWENTY_NANO	: time := 20 ns;
	signal hps_led_controller	: boolean := false;
	signal base_period_tb	: unsigned(7 downto 0) := "00001000";
	signal led_reg_qu	: std_logic_vector(7 downto 0) := "00000000";

begin
	
	ledPatterns : component led_patterns
			generic map(
				system_clock_period => TWENTY_NANO
			)
			port map(
				clk				=> fpga_clk1_50,
				rst				=> not push_button_n(0),
				push_button		=> not push_button_n(1),
				switches			=> sw(3 downto 0),
				hps_led_control	=> hps_led_controller,
				base_period		=> base_period_tb,
				led_reg			=> led_reg_qu,
				led				=> led(7 downto 0)
			);

end architecture DE10Nano_arch;




