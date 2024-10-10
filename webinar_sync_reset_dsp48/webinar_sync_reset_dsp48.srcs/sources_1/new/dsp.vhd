library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reset_sync_example is
  Port ( 
  i_resetn : in std_logic;
  i_clk : in std_logic;
  
  i_a : in std_logic_vector(15 downto 0);
  i_b : in std_logic_vector(15 downto 0);
  o_res : out std_logic_vector(31 downto 0));
  
end reset_sync_example;

architecture Behavioral of reset_sync_example is


signal s_a_delay_0 : std_logic_vector(15 downto 0);
signal s_b_delay_0 : std_logic_vector(15 downto 0);
signal s_a_delay_1 : std_logic_vector(15 downto 0);
signal s_b_delay_1 : std_logic_vector(15 downto 0);

begin

sync: process(i_clk,i_resetn) 
begin 
    if rising_edge(i_clk) then
        if i_resetn = '1' then 
        s_a_delay_0 <= (others =>'0');
        s_b_delay_0 <= (others =>'0');
        s_a_delay_1 <= (others =>'0');
        s_b_delay_1 <= (others =>'0');
        o_res <= (others =>'0');
     else
        --implement 2 registers for the DSP48 
        s_a_delay_0 <= i_a;
        s_b_delay_0 <= i_b;
        s_a_delay_1 <= s_a_delay_0;
        s_b_delay_1 <= s_b_delay_0;
        o_res <= std_logic_vector(unsigned(s_a_delay_1) * unsigned(s_b_delay_1)) ;
     end if;
    end if;
end process;
end Behavioral;