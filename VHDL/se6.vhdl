library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE6 is
    port (
        input : in std_logic_vector (5 downto 0);
        output : out std_logic_vector (15 downto 0)
    );
end entity;

architecture arch of SE6 is
begin
    output(5 downto 0) <= input;
    process(input)
        begin
            if input(5) = '1' then
	            output(15 downto 6) <= (others=>'1');
            else
	            output(15 downto 6) <= (others=>'0');
            end if;
        end process;
end arch;