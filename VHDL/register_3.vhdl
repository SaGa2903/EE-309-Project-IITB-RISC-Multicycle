library ieee;
use ieee.std_logic_1164.all;

entity reg_3 is
    port(
        sel: in std_logic_vector(1 downto 0);
        reset, CLK, EN: in std_logic;
        in_0, in_1, in_2, in_3: in std_logic_vector(15 downto 0);
        output: out std_logic_vector(15 downto 0)
	);
end entity;

architecture arch of reg_3 is
begin
    r1: process(CLK, sel, EN, in_0, in_1, reset)

    begin
        if CLK'event and CLK='0' then
            if reset='1' then
                output(15 downto 0) <= (others => '0');
            elsif EN ='1' then
                if sel="00" then
                    output <= in_0;
                elsif sel ="01" then 
                    output <= in_1;
                elsif sel = "10" then
                    output <= in_2;
                else 
                    output <= in_3;
                end if;
            end if ;  
        end if ;
    end process;
end arch;