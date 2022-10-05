----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2022 11:14:50 AM
-- Design Name: 
-- Module Name: RSA - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RSA is
    Port (
    clk, reset : in std_logic;
    a : in std_logic_vector(255 downto 0);
    b, n : in std_logic_vector(255 downto 0);
    r : out std_logic_vector(255 downto 0)
    );
end RSA;

architecture Behavioral of RSA is
    component Blakley is
        Port (
            clk: in std_logic;
            reset: in std_logic;
            a: in std_logic_vector(255 downto 0);
            b: in std_logic_vector(255 downto 0);
            n: in std_logic_vector(255 downto 0);
            r: out std_logic_vector(255 downto 0)
            );
	end component;
	
    signal internal_r: std_logic_vector(255 downto 0) := (others => '0');
    signal internal_a: std_logic_vector(255 downto 0) := (others  => '0');
    signal mux1: std_logic_vector(255 downto 0) := (others  => '0');
    signal mux2: std_logic_vector(255 downto 0) := (others  => '0');
    signal mux_in: std_logic_vector(255 downto 0) := (others => '0');
    signal mode: bit:= '1';
    


begin
    mux1 <= a when mode = '1' else
    std_logic_vector(mux_in) when mode = '0' else 
    (others => '1');
    
    mux2 <= b when mode = '1' else
    std_logic_vector(mux_in) when mode = '0' else 
    (others => '1');
    
    A1: Blakley port map (a => mux1, b => mux2, r => mux_in, clk => clk, reset => reset, n => n);
    
    
    r <= internal_r;
    process(clk, reset) is
    variable b_temp: unsigned(255 downto 0);
    begin
        mode <= '1';
        if reset = '1' then
            internal_r <= (others => '0');
        elsif rising_edge(clk) then 
            if b(255) = '1' then
                internal_r <= a;
            else 
                internal_r <= (others => '0');
            end if;
            
            for i in b'length-1 downto 0 loop
                mode <= '1';
                internal_r <= mux_in;
                if b(i) = '1' then
                    mode <= '0';
                    internal_r <= mux_in;
                end if;
            end loop;
        end if;
    end process;
end architecture;


