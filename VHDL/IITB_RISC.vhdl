library ieee;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_1164.all;

entity risc is
    port( clk, rst: in std_logic);
end entity;

architecture arch of risc is 

    component dataflow is
        port(
        state_id: in std_logic_vector(4 downto 0);
        state_cw: in std_logic_vector(34 downto 0);
        clk, reset: in std_logic;

        c, z, eq : out std_logic;  -- eq to be clarified
        opcode: out std_logic_vector(3 downto 0);
        cz : out std_logic_vector(1 downto 0)       -- cz is the condition bit from instruction
    );

    end component;

    component Controller is
        port(
            clk, rst, c, z, eq_out : in std_logic;  -- eq to be clarified
            opcode: in std_logic_vector(3 downto 0);
            cz : in std_logic_vector(1 downto 0);       -- cz is the condition bit from instruction
            state_id: out std_logic_vector(4 downto 0);
            state_cw: out std_logic_vector(34 downto 0)
        ); 
    end component;

    signal state_sig :std_logic_vector(4 downto 0);
    signal state_cw_sig : std_logic_vector(34 downto 0);
    signal c_sig, z_sig, eq_sig :std_logic;
    signal opcode_sig : std_logic_vector(3 downto 0);
    signal cz_sig : std_logic_vector(1 downto 0);
    
    
begin
    data: dataflow
    port map(opcode => opcode_sig, cz=>cz_sig, c=>c_sig, z=>z_sig, eq=> eq_sig, clk=> clk, 
             reset=> rst, state_cw=> state_cw_sig, state_id=> state_sig);

    control: Controller
    port map(opcode => opcode_sig, cz=>cz_sig, c=>c_sig, z=>z_sig, eq_out=> eq_sig, clk=> clk, 
    rst=> rst, state_cw=> state_cw_sig, state_id=> state_sig);

end architecture;
    
