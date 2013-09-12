library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- declare an empty entity (TODO: rename to something meaningnful such as
-- "tb_<name of the circuit being tested>")
entity tb is
end entity tb;

architecture a0 of tb is

  -- the basic signals
  constant CLK_PERIOD : time      := 20 ns;
  signal   clk        : std_logic := '0';  -- the clock
  signal   resetn     : std_logic := '0';
  
  -- TODO: declare other testbench signals here (such as the inputs to the
  -- circuit being tested)
  
begin  -- a0

  -- create the clock
  clk <= not clk after CLK_PERIOD/2;

  -- asynchronous reset
  resetn <= '0', '1' after 2*CLK_PERIOD;

  -- TODO: instantiate the component to be tested (replace "CUT" with the
  -- actual entity name, and fix the port map)
  xCUT: entity work.CUT
    port map (
      clk   => clk,
      rstn  => rstn,
      port1 => etc);

end a0;
