library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dataflow is
    port(
        state_id: in std_logic_vector(4 downto 0);
        state_cw: in std_logic_vector(34 downto 0);
        clk, reset: in std_logic;

        c, z, eq : out std_logic;  -- eq to be clarified
        opcode: out std_logic_vector(3 downto 0);
        cz : out std_logic_vector(1 downto 0)       -- cz is the condition bit from instruction

    );
end entity;
    
architecture arch of dataflow is 
    component alu is
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
    end component;

    component reg_file is
        port (
            CLK ,reset: in std_logic;
            a2 : in std_logic_vector (2 downto 0);
            d1, d2 : out std_logic_vector(15 downto 0);
            ir11to9, ir8to6,ir5to3, cc_out: in std_logic_vector(2 downto 0);
            sh7, pc, t2, t3: in std_logic_vector(15 downto 0);
            rf_cw: in std_logic_vector(8 downto 0)
        );
    end component reg_file;

    component ir is
        port(
            input: in std_logic_vector(15 downto 0);
            ir5to0: out std_logic_vector(5 downto 0);
            ir8to0: out std_logic_vector(8 downto 0);
            ir11to9, ir8to6, ir5to3: out std_logic_vector(2 downto 0);
            ir7to0: out std_logic_vector(7 downto 0);
            ir15to12: out std_logic_vector(3 downto 0);
            ir1to0: out std_logic_vector(1 downto 0)
        );
    end component;

    component Shift7 is
        port (
            input : in std_logic_vector (15 downto 0);
            output : out std_logic_vector (15 downto 0)
        );
    end component;

    component Shift1 is
        port (
            input : in std_logic_vector (15 downto 0);
            output : out std_logic_vector (15 downto 0)
        );
    end component;

    component SE6 is
        port (
            input : in std_logic_vector (5 downto 0);
            output : out std_logic_vector (15 downto 0)
        );
    end component;

    component SE9 is
        port (
            input : in std_logic_vector (8 downto 0);
            output : out std_logic_vector (15 downto 0)
        );
    end component;

    component cond_check is
        port(
        input: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(2 downto 0);
        out_tc : out std_logic_vector(7 downto 0) 
        );
    end component;

    component reg_2 is
        port(
            sel, EN: in std_logic;
            reset, CLK: in std_logic;
            in_0, in_1: in std_logic_vector(15 downto 0);
            output: out std_logic_vector(15 downto 0)
        );
    end component;

    component reg_3 is
        port(
            sel: in std_logic_vector(1 downto 0);
            reset, CLK, EN: in std_logic;
            in_0, in_1, in_2, in_3: in std_logic_vector(15 downto 0);
            output: out std_logic_vector(15 downto 0)
        );
    end component;
	 
	 component reg_tc is
    port(
        sel, EN: in std_logic;
        reset, CLK: in std_logic;
        in_0, in_1: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0)
	     );
	 end component;

    component mem is
        port(
            d1, t1, t3: in std_logic_vector(15 downto 0);
            clk: in std_logic;
            mem_cw: in std_logic_vector(3 downto 0);
            d_out: out std_logic_vector(15 downto 0)
        );
    end component mem;
    
    signal rf_d1, rf_d2,alu_c_out, t1_out, mem_d_out, t3_out, pc_out, se6_out, se9_out,sh7_out,sh1_out,t2_out: std_logic_vector(15 downto 0):= (others => '0');
    signal i8to6,i11to9,i5to3,cc_out_sig: std_logic_vector(2 downto 0):= (others => '0');
    signal i5to0: std_logic_vector(5 downto 0):= (others => '0');
    signal i8to0: std_logic_vector(8 downto 0):= (others => '0');
    signal i7to0, cc_addr_out, tc_out: std_logic_vector(7 downto 0):= (others => '0');
    signal i15to12: std_logic_vector(3 downto 0):= (others => '0');
    signal z_sig, cy_sig,eq_out: std_logic:= '0';
    signal i1to0: std_logic_vector(1 downto 0):= (others => '0');


    begin
        t1: reg_2 port map(
            sel=> state_cw(34),
            EN=> state_cw(33),
            reset=> reset,
            clk => clk,
            in_0 => rf_d1,
            in_1 => alu_c_out,
            output=> t1_out
            );

        tc: reg_tc port map(
            sel=> state_cw(27),
            EN=> state_cw(26),
            reset=> reset,
            clk => clk,
            in_0 => cc_addr_out,
            in_1 => i7to0,
            output=> tc_out
            );

        t3: reg_2 port map(
            sel=> state_cw(29),
            EN=> state_cw(28),
            reset=> reset,
            clk => clk,
            in_0 => mem_d_out,
            in_1 => alu_c_out,
            output=> t3_out
            );
        
        pc: reg_2 port map(
            sel=> state_cw(25),
            EN=> state_cw(24),
            reset=> reset,
            clk => clk,
            in_0 => rf_d1,
            in_1 => alu_c_out,
            output=> pc_out
            );
        
        t2: reg_3 port map(
            sel=> state_cw(32 downto 31),
            EN=> state_cw(30),
            reset=> reset,
            clk => clk,
            in_0 => rf_d2,
            in_1 => se6_out,
            in_2=> se9_out,
            in_3=> mem_d_out,
            output=> t2_out
            );
        
        rf: reg_file port map(
            reset=> reset,
            clk => clk,
            a2=> i8to6,
            d1=> rf_d1,
            d2=> rf_d2,
            ir11to9=> i11to9,
            ir5to3=> i5to3,
            ir8to6=> i8to6,
            cc_out=> cc_out_sig,
            sh7=>sh7_out,
            pc=>pc_out,
            t2=> t2_out,
            t3=> t3_out,
            rf_cw=> state_cw(19 downto 11)
        );

        memory: mem port map (
            clk => clk,
            d1 => rf_d1,
            t1 => t1_out,
            t3 => t3_out,
            d_out => mem_d_out,
            mem_cw => state_cw(23 downto 20)

        );

        Instruction_register: ir port map (
            input => mem_d_out,
            ir5to0 => i5to0,
            ir8to0 => i8to0,
            ir11to9 => i11to9,
            ir8to6 => i8to6,
            ir5to3 => i5to3,
            ir7to0 => i7to0,
            ir15to12 => i15to12,
            ir1to0=> i1to0
        );

        SE9_16: SE9 port map(

            input => i8to0,
            output => se9_out
        );

        SE6_16: SE6 port map(

            input => i5to0,
            output => se6_out
        );

        Shifter_7: Shift7 port map(

            input => se9_out,
            output => sh7_out


        );

        Shifter_1: Shift1 port map(
            input => t2_out,
            output => sh1_out
        );
        
        CC: cond_check port map(
            out_tc=> cc_addr_out,
            output=> cc_out_sig,
            input=>tc_out
        );

        alu_1: alu port map(
            clk=>clk,
            alu_op=> i15to12,
            t1=> t1_out,
            pc=>pc_out,
            se6=>se6_out,
            t2=>t2_out,
            shift1=> sh1_out,
            CY=>cy_sig,
            Z=>z_sig,
            Cin=>cy_sig,
            alu_c=> alu_c_out,
            alu_cw=> state_cw(4 downto 1)

        );

        c<= cy_sig;
        z<= z_sig;
        eq<=eq_out;
        cz<= i1to0;
        opcode<= i15to12;

    end arch;