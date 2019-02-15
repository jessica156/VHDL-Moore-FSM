----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jessica Nguyen
-- 
-- Create Date: 02/11/2019 08:45:54 PM
-- Design Name: Moore FSM
-- Module Name: fsm_tb - tb_arch
-- Project Name: Moore FSM
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for the moore finite state machine
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_tb is
end fsm_tb;

architecture tb_arch of fsm_tb is
    signal clk, reset, din: std_logic;
    signal count: std_logic_vector(7 downto 0);
    signal test_vector1: std_logic_vector(31 downto 0) := "11001010110100100110101010011101";
    signal test_vector2: std_logic_vector(23 downto 0) := "111010101001000010010111";
begin
    uut: entity work.fsm(moore)
        port map(
            clock => clk,
            reset => reset,
            din => din,
            count => count
        );
        
    clock: process
    begin
        clk <= '0';
        wait for 50ns;
        clk <= '1';
        wait for 50ns;
    end process clock;
    
    test_vector_gen: process
    begin
        -- Test vector = 11001010110100100110101010011101
        reset <= '1';
        din <= '0';
     
        wait until falling_edge(clk);
        reset <= '0';
        
        for i in 31 downto 0 loop
            wait until falling_edge(clk);
            din <= test_vector1(i);
        end loop;
        
        wait until falling_edge(clk);
        reset <= '1';
        din <= '0';
        
        wait until falling_edge(clk);
        reset <= '0';
        
        for i in 23 downto 0 loop
            wait until falling_edge(clk);
            din <= test_vector2(i);
        end loop;
        
        wait until falling_edge(clk);
        reset <= '1';
        din <= '0';
        
        wait until falling_edge(clk);
        
        assert false;
            report "Simulation Completed"
        severity failure;
    end process test_vector_gen;
end tb_arch;
