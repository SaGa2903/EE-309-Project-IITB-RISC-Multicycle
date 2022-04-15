library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity reg_file is
port (
    CLK ,reset: in std_logic;
    a2 : in std_logic_vector (2 downto 0);
    d1, d2 : out std_logic_vector(15 downto 0);
    ir11to9, ir8to6, cc_out: in std_logic_vector(2 downto 0);
    s7, pc, t2, t3: in std_logic_vector(15 downto 0)
    rf_cw: in std_logic_vector(8 downto 0)
  );
end entity reg_file;

architecture arch of reg_file is


-- component reg is
--   generic (NO_OF_BITS: integer:=16);
--   port(  
--       EN, reset, CLK: in std_logic;
--       input: in std_logic_vector(NO_OF_BITS-1 downto 0);
--       output: out std_logic_vector(NO_OF_BITS-1 downto 0)
--   );
-- end component;

architecture arch of reg_file is
  begin

  signal r0, r1, r2, r3, r4, r5, r6, r7,d3: std_logic_vector(15 downto 0);
  signal a1,a3: std_logic_vector(2 downto 0);

  p1: process(rf_cw, ir11to9, ir8to6, cc_out, s7, t2, t3, pc)
    -- mux1: process(rf_cw(5 downto 4), ir11to9,ir8to6,cc_out)
    -- begin
      case rf_cw(5 downto 4) is
        when "00" =>
          a1<= "111";
        when "01" =>
          a1<= ir11to9;
        when "10" =>
          a1<= ir8to6;    
        when others =>
          a1<= cc_out;
      end case; 
    -- end process;

    -- mux3: process(rf_cw(3 downto 2), ir11to9,ir8to6,cc_out)
    -- begin
      case rf_cw(3 downto 2) is
        when "00" =>
          a3<= "111";
        when "01" =>
          a3<= ir11to9;
        when "10" =>
          a3<= ir8to6;    
        when others =>
          a3<= cc_out;
      end case; 
    -- end process;

    -- mux4: process(rf_cw(1 downto 0), s7, t2, t3, pc)
    -- begin
      case rf_cw(3 downto 2) is
        when "00" =>
          d3<= s7;
        when "01" =>
          d3<= t3;
        when "10" =>
          d3<= pc;    
        when others =>
          d3<= t2;
      end case; 
    -- end process;

    -- wr: process(a1,CLK, rf_cw(6))
    --   begin
      if(reset= '1') then
        r0 <= (others <= '0');
        r1 <= (others <= '0');
        r2 <= (others <= '0');
        r3 <= (others <= '0');
        r4 <= (others <= '0');
        r5 <= (others <= '0');
        r6 <= (others <= '0');
        r7 <= (others <= '0');
      elsif(CLK'event and CLK='0') then
          if (rf_cw(6)='1') then
            case a3 is
              when "000" =>
                r0<= d3;
              when "001" =>
                r1<= d3;
              when "010" =>
                r2<= d3;
              when "011" =>
                r3<= d3;
              when "100" =>
                r4<= d3;
              when "101" =>
                r5<= d3; 
              when "110" =>
                r6<= d3;
              when others =>
                r7<= d3;              
            end case;
          end if;
      end if;

      --write
      if(rf_cw(8) = '1') then
        case a1 is
          when "000" =>
            d1<= r0;
          when "001" =>
            d1<= r1;
          when "010" =>
            d1<= r2;
          when "011" =>
            d1<= r3;
          when "100" =>
            d1<= r4;
          when "101" =>
            d1<= r5; 
          when "110" =>
            d1<= r6;
          when others =>
            d1<= r7;              
        end case;
      end if;      
      
      --write
      if(rf_cw(7) = '1') then
        case a2 is
          when "000" =>
            d1<= r0;
          when "001" =>
            d1<= r1;
          when "010" =>
            d1<= r2;
          when "011" =>
            d1<= r3;
          when "100" =>
            d1<= r4;
          when "101" =>
            d1<= r5; 
          when "110" =>
            d1<= r6;
          when others =>
            d1<= r7;              
        end case;
      end if; 
  end process;

end arch;





