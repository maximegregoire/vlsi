library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

package sdrampack is

  function to_integer(arg       : std_logic_vector) return integer;
  function to_integer (arg      : std_logic) return integer;
  function to_int_chklevel (arg : std_logic_vector) return integer;

end sdrampack;

package body sdrampack is

  function to_integer(arg : std_logic_vector) return integer is
    variable result : integer;
  begin
--synopsys synthesis_off
    assert arg'length <= 31
                         report "arg is too large in CONV_INTEGER"
                         severity failure;
--synopsys synthesis_on
    result := 0;
    for i in arg'reverse_range loop
      if arg(i) = '1' then
        result := result + 2 ** i;
      end if;
    end loop;
    return result;
  end;


  function to_integer (arg : std_logic) return integer is
  begin
    if (arg = '1') then
      return (1);
    else
      return (0);
    end if;
  end to_integer;

  function to_int_chklevel(arg : std_logic_vector) return integer is

    variable result   : integer;
    variable badLevel : integer;

  begin
--synopsys synthesis_off

    assert arg'length <= 31
                         report "arg is too large in CONV_INTEGER"
                         severity failure;
--synopsys synthesis_on

    result   := 0;
    badLevel := 0;
    for i in arg'reverse_range loop
      if arg(i) = '1' then
        result := result + 2 ** i;

      elsif (arg(i) /= '0') then
        badLevel := 1;
      end if;
    end loop;
    if (badLevel = 1) then
      return (-1);
    else
      return (result);
    end if;
  end to_int_chklevel;


end sdrampack;



