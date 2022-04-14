library ieee;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_1164.all;

entity cond_check is
    port(
      input: in std_logic_vector(15 downto 0);
      output: out std_logic_vector(15 downto 0); 
    );
end entity;

architecture arch of cond_check is
    signal out_temp: std_logic_vector(2 downto 0) :="000";
    signal out_inc: std_logic_vector(2 downto 0) :="000";

    begin
        cc: process(input)
            begin
                for i in 0 to 7 loop
                    if input(i)='1' then
                        out_temp <= out_inc;
                    end if
                    out_inc <=  out_inc + "001"; -- !!! Check for error here              
                end loop;
            end process;

            output<= out_temp;
end arch;



