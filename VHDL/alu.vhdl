library ieee;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_1164.all;

entity alu is
    port(
        alu_op: in std_logic_vector(1 downto 0);
        alu_a: in std_logic_vector(15 downto 0);
        alu_b: in std_logic_vector(15 downto 0);
        CY: out std_logic;
        Z: out std_logic;
        Cin: in std_logic;
        alu_c: out std_logic_vector(15 downto 0)
        -- CLK: in std_logic
    );
    end entity;

architecture arch of alu is
begin
    alu1: process(alu_a, alu_b, Cin, alu_op)
        variable alu_out, temp_a, temp_b: std_logic_vector(16 downto 0);
        temp_a := '0' & alu_a;
        temp_b := '0' & alu_b;
        CY <= Cin;
        if alu_op(1) = '0' then --op ="00" | op="01"
            alu_out := std_logic_vector(unsigned(temp_a)+unsigned(temp_b));
            CY <= alu_out(16);
        elsif alu_op = "10" then
            alu_out(15 downto 0) := temp_a(15 downto 0) nand temp_b(15 downto 0);
        else 
            alu_out(16 downto 0):= (others=>"0");
        end if;

        if alu_out(15 downto 0)="0000000000000000" then
            Z <= '1';
        else Z<= '0';
        end if;
        
        alu_c <= alu_out(15 downto 0);

    end process;
    end arch;
        






