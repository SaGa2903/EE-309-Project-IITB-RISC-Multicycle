library ieee;
use ieee.std_logic_1164.all;

entity reg is
    generic (NO_OF_BITS: integer:=16);
    port(  
        EN, reset, CLK: in std_logic;
        input: in std_logic_vector(NO_OF_BITS-1 downto 0);
        output: out std_logic_vector(NO_OF_BITS-1 downto 0)
	);
end entity;

architecture arch of reg is
begin
    r1: process(CLK, EN, input,reset)

    begin
        if CLK'event and CLK='1' then
            if reset='1' then
                output( NO_OF_BITS-1 downto 0) <= (others <= '0');
            elsif EN ='1' then
                output <= input; 
            end if ;  
        end if ;
    end process;
end arch;