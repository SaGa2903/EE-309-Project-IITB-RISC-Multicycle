library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ir is
    port(
        input: in std_logic_vector(15 downto 0);
        ir5to0: out std_logic_vector(5 downto 0);
        ir8to0: out std_logic_vector(8 downto 0);
        ir11to9, ir8to6, ir5to3: out std_logic_vector(2 downto 0);
        ir7to0: out std_logic_vector(7 downto 0);
        ir15to12: out std_logic_vector(3 downto 0);
        ir13to12
    );
end entity;

architecture arch of ir is
begin

    ir5to0 <= input(5 downto 0);
    ir8to0 <= input(8 downto 0);
    ir11to9<= input(11 downto 9);
    ir8to6 <= input(8 downto 6);
    ir5to3 <= input(5 downto 3);
    ir7to0 <= input(7 downto 0);
    ir15to12 <= input(15 downto 12);

end arch;