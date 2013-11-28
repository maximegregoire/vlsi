-------------------------------------------------------------------------------
-- Author: Francois Leduc-Primeau
--
-- This template shows you one approach for creating a VHDL testbench
-- that reads input vectors from a file, and reads expected outputs from a
-- second file. It then checks that the outputs generated by the circuit under
-- test (CUT) match the expected outputs.
--
-- Note that this file doesn't compile as is, it must be edited in several
-- places.
-------------------------------------------------------------------------------

library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- declare an empty entity (TODO: rename to something meaningnful such as
-- "tb_<name of the circuit being tested>")
entity tb is
end entity tb;

architecture a0 of tb is                --TODO: rename "tb" here too

  -- the basic signals
  constant CLK_PERIOD : time      := 20 ns;
  signal   clk        : std_logic := '0';  -- the clock
  signal   resetn     : std_logic := '0';

  -- test vector input file
  -- Make sure this file is in your simulation directory.
  constant tv_file_in : string := "mytestvectors.txt";
  --constant TV_LINESIZE : integer := 1;  -- number of elements per line

  -- input file for expected output
  constant tv_file_expected : string  := "myexpectedoutput.txt";
  constant TVEXP_LINESIZE   : integer := 3;  -- number of elements per line

  -- TODO: declare other testbench signals here (such as the inputs to the
  -- circuit being tested)
  -- Note that the types of these signals are just examples.
  signal byteInput_s  : unsigned(7 downto 0);
  signal cutOutput0_s : unsigned(15 downto 0);  -- output of circuit being tested
  signal cutOutput1_s : unsigned(15 downto 0);
  signal cutOutput2_s : unsigned(15 downto 0);
  type   expected_t is array (0 to TVEXP_LINESIZE-1) of unsigned(15 downto 0);
  signal expOutput_s  : expected_t;     -- list of expected outputs
  -- then we can check that cutOutput0_s = expOutput_s(0), and so on...
  
begin  -- a0

  -- create the clock
  clk <= not clk after CLK_PERIOD/2;

  -- read-in test vectors
  p_tv : process is
    file f_data_in       : text open read_mode is tv_file_in;
    file f_data_expected : text open read_mode is tv_file_expected;
    variable inline      : line;
    variable expline     : line;
    variable curByte     : integer range 0 to 255;
    variable curOutput   : integer range 0 to 65535;

  begin
    -- asynchronous reset (active low)
    resetn <= '0';
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    resetn <= '1';
    wait until rising_edge(clk);
    wait until rising_edge(clk);

    while not endfile(f_data_in) loop   -- assumes f_data_expected has the same
                                        -- number of lines as f_data_in
      readline(f_data_in, inline);
      readline(f_data_expected, expline);

      -- Read one integer from the input file
      read(inline, curByte);
      byteInput_s <= to_unsigned(curByte, 8);

      -- Read TVEXP_LINESIZE integers from the expected output file
      for i in 0 to TVEXP_LINESIZE-1 loop
        read(expline, curOutput);
        expOutput_s(i) <= to_unsigned(curOutput, 16);
      end loop;

      wait until rising_edge(clk);
    end loop;
    
  end process;

  -- TODO: instantiate the component to be tested (replace "CUT" with the
  -- actual entity name, and fix the port map)
  xCUT : entity work.CUT
    port map (
      clk         => clk,
      rstn        => resetn,
      inputport0  => byteInput_s,
      outputport0 => cutOutput0_s,
      outputport1 => cutOutput1_s,
      outputport2 => cutOutput2_s
      );

  -- Check actual output against expected output
  -- Note that you might need to pipeline the expected output signal to match the
  -- latency of your circuit.
  p_chk : process (clk) is
  begin  -- process p_chk
    if resetn = '0' then

    elsif rising_edge(clk) then
      assert cutOutput0_s = expOutput_s(0)
        report "Output #0 doesn't match expected!" severity warning;
      assert cutOutput1_s = expOutput_s(1)
        report "Output #1 doesn't match expected!" severity warning;
      assert cutOutput2_s = expOutput_s(2)
        report "Output #2 doesn't match expected!" severity warning;
    end if;
  end process p_chk;

end a0;
