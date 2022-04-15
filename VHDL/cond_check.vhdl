library ieee;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_1164.all;

entity cond_check is
    port(
      input: in std_logic_vector(15 downto 0);
      output: out std_logic_vector(15 downto 0);
      out_tc : out std_logic_vector(15 downto 0) 
    );
end entity;

architecture arch of cond_check is
    begin
        cc: process(input)
            begin
                if ip(0) = '1' then
                    output <= "000";
                    out_tc(7 downto 1) <= ip(7 downto 1);
                    out_tc(0) <= '0';
                elsif ip(1) = '1' then
                    output <= "001";
                    out_tc(7 downto 2) <= ip(7 downto  2);
                    out_tc(1 downto 0) <= "00";
                elsif ip(2) = '1' then
                    output <= "010";
                    out_tc(7 downto 3) <= ip(7 downto 3);
                    out_tc(2 downto 0) <= "000";
                elsif ip(3) = '1' then
                    output <= "011";
                    out_tc(7 downto 4) <= ip(7 downto 4);
                    out_tc(3 downto 0) <= "0000";
                elsif ip(4) = '1' then
                    output <= "100";
                    out_tc(7 downto 5) <= ip(7 downto 5);
                    out_tc(4 downto 0) <= "00000";
                elsif ip(5) = '1' then
                    output <= "101";
                    out_tc(7 downto 6) <= ip(7 downto 6);
                    out_tc(5 downto 0) <= "000000";
                elsif ip(6) = '1' then
                    output <= "110";
                    out_tc(7) <= ip(7);
                    out_tc(6 downto 0) <= "0000000";
                elsif ip(7) = '1' then
                    output <= "111";
                    out_tc <= "00000000";
                else
                    output <= (others => '0');
                    out_tc <= (others => '0');
                end if;
            end process;
end arch;



