library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity S1 is
    port (
        input : in std_logic_vector (15 downto 0);
        output : out std_logic_vector (15 downto 0)
    );
end entity;

architecture arch of S1 is
begin
    output(15 downto 1) <= input(14 downto 0);
    output(0) <= '0';
end arch;