----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jessica Nguyen
-- 
-- Create Date: 02/07/2019 03:45:06 PM
-- Design Name: Moore FSM
-- Module Name: fsm - architecture
-- Project Name: Moore FSM
-- Target Devices: 
-- Tool Versions: 
-- Description: The finite state machine recognizes two strings "1001" and "0101", count how many times they appear in a string of
-- input, and output that number.
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm is
    Port(
        clock: in std_logic;
        reset: in std_logic;    -- Reset signal to reset the FSM
        din: in std_logic;      -- Reads in one bit input at a time
        count: out std_logic_vector(7 downto 0)     -- Count how many times the strings "1001" and "0101" are found
    );
end fsm;

architecture moore of fsm is
    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
    signal state: state_type;
    signal counter: std_logic_vector(7 downto 0) := (others => '0');
begin
    process(clock)
    begin
        if rising_edge(clock) then
            if reset = '1' then
                state <= s0;
                counter <= "00000000";
            else
                case state is
                    when s0 =>
                        if din = '1' then
                            state <= s1;
                        else
                            state <= s2;
                        end if;
                    when s1 =>
                        if din = '0' then
                            state <= s3;
                        else
                            state <= s1;
                        end if;
                    when s2 =>
                        if din = '1' then
                            state <= s5;
                        else
                            state <= s2;
                        end if;
                    when s3 =>
                        if din = '1' then
                            state <= s5;
                        else
                            state <= s4;
                        end if;
                    when s4 =>
                        if din = '1' then
                            state <= s7;
                        else
                            state <= s2;
                        end if;
                    when s5 =>
                        if din = '0' then
                            state <= s6;
                        else
                            state <= s1;
                        end if;
                    when s6 =>
                        if din = '1' then
                            state <= s7;
                        else
                            state <= s4;
                        end if;
                    when s7 =>
                        counter <= counter + 1;
                        if din = '0' then
                            state <= s6;
                        else
                            state <= s1;
                        end if;
                end case;
            end if;    
        end if;        
    end process;
    count <= counter;
end moore;
