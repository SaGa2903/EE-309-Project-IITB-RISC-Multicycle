library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE9 is
    port (
        input : in std_logic_vector (8 downto 0);
        output : out std_logic_vector (15 downto 0)
    );
end entity;

architecture arch of SE9 is
begin
    output(8 downto 0) <= input;
    process(input)
        begin
            if input(8) = '1' then
	            output(15 downto 9) <= (others=>'1');
            else
	            output(15 downto 9) <= (others=>'0');
            end if;
        end process;
end arch;