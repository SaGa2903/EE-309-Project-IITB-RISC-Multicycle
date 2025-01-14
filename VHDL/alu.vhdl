library ieee;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_1164.all;

entity alu is
    port(
        alu_op: in std_logic_vector(3 downto 0);
        t1, pc, se6, t2, shift1: in std_logic_vector(15 downto 0);
        -- alu_b: in std_logic_vector(15 downto 0);
        CY: out std_logic;
        Z: out std_logic;
        Cin,clk: in std_logic;
        alu_c: out std_logic_vector(15 downto 0);
        alu_cw: in std_logic_vector(3 downto 0)
        -- CLK: in std_logic
    );
end entity;

architecture arch of alu is
    signal alu_a, alu_b: std_logic_vector(15 downto 0);
	 signal alu_out, temp_a, temp_b: std_logic_vector(16 downto 0);

begin
    alu1: process(t1, pc, se6, t2, shift1, Cin, alu_op)

		begin
        case alu_cw(2) is
            when '0' =>
              alu_a <= t1;
            when others =>
              alu_a <= pc;
        end case;

        case alu_cw(1 downto 0) is
            when "00" =>
              alu_b<= X"0001";
            when "01" =>
              alu_b<= se6;
            when "10" =>
              alu_b<= t2;    
            when others =>
              alu_b<= shift1;
          end case; 
          
        temp_a <= '0' & alu_a;
        temp_b <= '0' & alu_b;
        CY <= Cin;
        if alu_op = "0010" then
          alu_out(15 downto 0) <= temp_a(15 downto 0) nand temp_b(15 downto 0);
        -- if alu_cw(2) ='1' or alu_op(1) = '0' then --op ="00" | op="01" or alu_a=pc
        --     alu_out := std_logic_vector(unsigned(temp_a)+unsigned(temp_b));
        --     CY <= alu_out(16);
        -- elsif alu_op = "0010" then
        --     alu_out(15 downto 0) := temp_a(15 downto 0) nand temp_b(15 downto 0);
        else 
          alu_out <= std_logic_vector(unsigned(temp_a)+unsigned(temp_b));
			 CY <= alu_out(16);
--          if(clk'event and clk='0') then
--            CY <= alu_out(16);
--          end if;
        end if;

        if alu_out(15 downto 0)="0000000000000000" then
            Z <= '1';
        else Z<= '0';
        end if;
        
        alu_c <= alu_out(15 downto 0);

    end process;
    end arch;
        






