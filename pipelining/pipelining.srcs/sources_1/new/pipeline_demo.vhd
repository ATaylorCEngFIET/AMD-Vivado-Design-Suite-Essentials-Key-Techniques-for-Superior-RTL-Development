library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is port(
    i_clk   : in std_logic;
    i_a     : in std_logic_vector(7 downto 0);
    i_b     : in std_logic_vector(7 downto 0); 
    i_c     : in std_logic_vector(7 downto 0); 
    i_d     : in std_logic_vector(7 downto 0); 
    i_e     : in std_logic_vector(7 downto 0); 
    
    i_mode  : in std_logic;
    
    
    o_res   : out std_logic_vector(31 downto 0) 
   
);
end entity;

architecture rtl of pipeline is 

    --type reg_array is array (4 downto 0) of std_logic_vector(31 downto 0);

    --constant offset_a   : unsigned(7 downto 0):= x"55";
    --constant offset_b   : unsigned(7 downto 0):= x"12";
    signal s_res        : std_logic_vector(31 downto 0);
    signal s_a          : std_logic_vector(7 downto 0);
    signal s_b          : std_logic_vector(7 downto 0);
    signal s_c          : std_logic_vector(7 downto 0);
    signal s_d          : std_logic_vector(7 downto 0);
    signal s_e          : std_logic_vector(7 downto 0);
    --signal pipeline_reg : reg_array;
    
    signal s_pipe1          : std_logic_vector(31 downto 0);
    signal s_pipe2          : std_logic_vector(31 downto 0);
    signal s_pipe3          : std_logic_vector(31 downto 0);
    signal s_pipe4          : std_logic_vector(31 downto 0);
    
    --attribute retiming_backward : integer;
   -- attribute retiming_backward of s_res : signal is 1;
   -- attribute retiming_backward of s_pipe1 : signal is 1;
   -- attribute retiming_backward of s_pipe2 : signal is 1;
    
begin


process(i_clk)
begin
    if rising_edge(i_clk) then 
        s_a <= i_a;
        s_b <= i_b;
        s_c <= i_c; 
        s_d <= i_d;
        s_e <= i_e; 
        s_res <= std_logic_vector((unsigned(s_a) * unsigned(s_d)) * ( unsigned(s_b) * unsigned(s_e)) - unsigned(s_c));
        s_pipe1 <= s_res;
        s_pipe2 <= s_pipe1;
        s_pipe3 <= s_pipe2;
        s_pipe4 <= s_pipe3;
        
        --pipeline_reg <= pipeline_reg(pipeline_reg'high -1 downto 0 ) & s_res;
    end if;
end process;

process(i_clk) 
begin
    if rising_edge(i_clk) then 
        if i_mode = '1' then 
            o_res <= s_pipe4;--pipeline_reg(pipeline_reg'high);
        else 
            o_res(31 downto 8) <= (others => '0');
            o_res(7 downto 0) <= i_a;
        end if;
    end if;
end process;


end architecture; 