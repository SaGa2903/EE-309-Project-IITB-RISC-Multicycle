library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity reg_file is
port (
    CLK ,reset: in std_logic;
    
  );
end entity reg_file;

architecture arch of reg_file is


component reg is
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic_vector(15 downto 0);
        op: out std_logic_vector(15 downto 0)
		  );
end component;


type rin is array(0 to 7) of std_logic_vector(15 downto 0);
signal reg_in,reg_out : rin;
signal wr_enable,wr_enable_final: std_logic_vector(7 downto 0);

begin

    rf_d1 <= reg_out(to_integer(unsigned(rf_a1)));
    rf_d2 <= reg_out(to_integer(unsigned(rf_a2)));

with rf_a3 select
 wr_enable <= 	"10000001" when "000",
					"10000010" when "001",
					"10000100" when "010",
					"10001000" when "011",
					"10010000" when "100",
					"10100000" when "101",
					"11000000" when "110",
					"10000000" when "111",
					"00000000" when others;

  reg_in(0) <= rf_d3;
  reg_in(1) <= rf_d3;
  reg_in(2) <= rf_d3;
  reg_in(3) <= rf_d3;
  reg_in(4) <= rf_d3;
  reg_in(5) <= rf_d3;
  reg_in(6) <= rf_d3;
with r7_wr_mux select reg_in(7) <=
        rf_d3 when "00",
        pc_to_r7 when "01",
        t2_to_r7 when "10",
        alu_to_r7 when "11",
		  (others => '0') when others;

wr_enable_final(0) <= wr_enable(0) and rf_wr;
wr_enable_final(1) <= wr_enable(1) and rf_wr;
wr_enable_final(2) <= wr_enable(2) and rf_wr;
wr_enable_final(3) <= wr_enable(3) and rf_wr;
wr_enable_final(4) <= wr_enable(4) and rf_wr;
wr_enable_final(5) <= wr_enable(5) and rf_wr;
wr_enable_final(6) <= wr_enable(6) and rf_wr;
wr_enable_final(7) <= wr_enable(7) and rf_wr; 

  R : for n in 0 to 7 generate
      Rn: reg port map(EN =>wr_enable_final(n),reset => reset,CLK => CLK,ip=>reg_in(n),op=>reg_out(n));
  end generate R;

end arch;