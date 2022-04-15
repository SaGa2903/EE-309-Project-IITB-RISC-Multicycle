library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity S7 is
    port (
        input : in std_logic_vector (15 downto 0);
        output : out std_logic_vector (15 downto 0)
    );
end entity;

architecture arch of S7 is
begin
    output(15 downto 7) <= input(8 downto 0);
    output(6 downto 0) <= "0000000";
end arch;