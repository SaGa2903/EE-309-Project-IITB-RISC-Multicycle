library ieee;
use ieee.std_logic_1164.all;

entity reg_tc is
    port(
        sel, EN: in std_logic;
        reset, CLK: in std_logic;
        in_0, in_1: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0)
	);
end entity;

architecture arch of reg_tc is
begin
    r1: process(CLK, sel, EN, in_0, in_1, reset)

    begin
        if CLK'event and CLK='0' then
            if reset='1' then
                output(7 downto 0) <= (others => '0');
            elsif EN ='1' then
                if sel='0' then
                    output <= in_0;
                else 
                    output<= in_1;
                end if;
            end if ;  
        end if ;
    end process;
end arch;