library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controller is
    port(
        clk, rst, c, z, eq : in std_logic;  -- eq to be clarified
        opcode: in std_logic_vector(3 downto 0);
        cz : in std_logic_vector(1 downto 0);       -- cz is the condition bit from instruction
        state_id: out std_logic_vector(4 downto 0)
    ); 
end entity;

architecture design of Controller is 

type states is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s_loop);

signal s_current, s_next : state := s0;

begin 

clock: process(clk, rst)
begin 

if (clk= '0' and clk' event) then
    if(rst='1') then
        s_current<= s0;
        s_next<= s0;
    else
        s_current<= s_next;
    end if;
end if;

end process;

state_transition: process(opcode, c,z, cz, eq_z, s_current) -- why opcode is necessary
begin 

case s_current is
    when s0=>
        state_id<="00000";
        s_next<= s1;
    when s1=>
        state_id<="00001";
        if(opcode= "0011") then  -- LHI
            s_next<=s8;
        elsif(opcode="0111" or opcode="0101") then -- LW and SW
            s_next<=s9;
        elsif(opcode= "1001") then --JAL
            s_next<= s16;
        elsif(opcode="1010") then --JLR
            s_next<= s18;
        elsif(opcode= "1011") then -- JRI
            s_next<= s19;
        elsif(opcode="1100")  then -- LM
            s_next<= s20;
        elsif(opcode= "1101") then -- SM
            s_next<= s23;
        elsif(opcode="0000") then -- ADI
            s_next<= s7;
        else s_next<= s2;
        end if;
    when s2=>
        state_id<= "00010";
        if( ((opcode="0001" or opcode="0010") and cz="00") or 
            ((opcode="0001" or opcode="0010") and cz="10" and c='1') or
            ((opcode="0001" or opcode="0010") and cz="01" and z='1') ) then
                s_next<= s3;
        elsif(opcode="0001" and cz="11") then
            s_next<=s6; 
        elsif(opcode="1000" ) then
            s_next<=s14;
        else
            s_next<=s5; -- conditipn of adc,ndc, adz, ndz with c/z=0
        end if;
    when s3=>
        state_id<="00011";
        if(opcode="0001" or opcode="0000" or opcode="0010") then
            s_next<= s4;
        elsif(opcode="0111") then    
            s_next<= s10;
        elsif(opcode="0101") then 
            s_next<= s12; 
        else
            s_next<= s17;       
        end if;
    when s4=>
        state_id<="00100";
        s_next<=s5;
    when s5=>
        state_id<="00101";
        s_next<=s0;
    when s6=>
        state_id<="00110";
        s_next<=s4;         
    when s7=>
        state_id<="00111";
        s_next<=s3;
    when s8=>
        state_id<="01000";
        s_next<=s5;
    when s9=>
        state_id<="01001";
        s_next<=s3;
    when s10=>
        state_id<="01010";
        s_next<=s11;
    when s11=>
        state_id<="01011";
        s_next<=s5;
    when s12=>
        state_id<="01100";
        s_next<=s13;
    when s13=>
        state_id<="01101";
        s_next<=s5;
    when s14=>
        state_id<="01110";
        s_next<=s15;         
    when s15=>
        state_id<="01111";
        if(eq_z='1') then 
            s_next<= s17;
        else 
            s_next<=s5;    
        end if;
    when s16=>
        state_id<="10000";
        s_next<=s3;
    when s17=>
        state_id<="10001";
        s_next<=s0;
    when s18=>
        state_id<="10010";
        s_next<=s5;
    when s19=>
        state_id<="10011";
        s_next<=s3;  
    when s20=>
        state_id<="10100";
        s_next<=s21;
    when s21=>
        state_id<="10101";
        s_next<=s22;
    when s22=>
        state_id<="10110";
        s_next<=s0;
    when s23=>
        state_id<="10111";
        s_next<=s24;     
    when s24=>
        state_id<="11000";
        s_next<=s0;
    when s_loop=>
        state_id<="11111";
        s_next<= s_loop;
end case;
end process;
end architecture;

        
    
    
    
        

