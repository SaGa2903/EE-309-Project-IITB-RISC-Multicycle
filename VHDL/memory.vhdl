library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
port(
    d1, t1, t3: in std_logic_vector(15 downto 0);
    clk: in std_logic;
    mem_cw: in std_logic_vector(3 downto 0);
    d_out: out std_logic_vector(15 downto 0)
);
end entity mem;

architecture arch of mem is
    signal add_in, d_in: std_logic_vector(15 downto 0);
    type mem_block is array (0 to 255) of std_logic_vector (15 downto 0); --512 Byte memory
    signal data_temp: mem_block := ("0001000001010000","0011000001010000", others => (others =>'0'));
begin

    p1: process(d1, t1, t3, mem_cw)
    
    begin

        if mem_cw(2 downto 1)="01" then
              add_in<= d1;	  
		  elsif mem_cw(2 downto 1)="10" then
              add_in<= t1;    
        elsif mem_cw(2 downto 1)="11" then
              add_in<= t3;
        end if; 
        
           
          case mem_cw(3) is
            when '1' =>
              d_in <= d1;
            when others =>
              d_in <= t1;
          end case;
        

        if(clk'event and clk = '0') then
          if (mem_cw(0)='1') then
            data_temp(to_integer(unsigned(add_in(7 downto 0)))) <= d_in;
          end if;
        end if;

    end process;

    d_out <= data_temp(to_integer(unsigned(add_in(7 downto 0))));

  end arch;




    
    
