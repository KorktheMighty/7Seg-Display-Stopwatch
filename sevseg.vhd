----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/12/2021 02:33:14 AM
-- Design Name: 
-- Module Name: sevseg - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sevseg is
    Port ( clk : in STD_LOGIC;
          reset : in STD_LOGIC;
           cnt0 : in STD_LOGIC_VECTOR (3 downto 0);
           cnt1 : in STD_LOGIC_VECTOR (3 downto 0);
           cnt2 :in  STD_LOGIC_VECTOR (3 downto 0);
           cnt3 : in STD_LOGIC_VECTOR (3 downto 0);
             an : out STD_LOGIC_VECTOR (3 downto 0);
            seg : out STD_LOGIC_VECTOR(6 downto 0);
            dp  : out STD_LOGIC);
       
           
end sevseg;

architecture Behavioral of sevseg is
signal x :  STD_LOGIC_VECTOR(3 downto 0);
signal wiredp       :  STD_LOGIC:='0';
--signal seg : STD_LOGIC_VECTOR(6 downto 0);


type state_type is (S0,S1,S2,S3);
signal ps,ns : state_type;
begin

dp <= wiredp;

OUTPUT_DECODE : process (ps) begin
    case (ps) is
      when S0 =>
        x <= cnt0;
        an <= "1110";
        wiredp<='1';
      when S1 =>
        wiredp<='0';
        x <= cnt1;
        an <= "1101";
      when S2 =>
        wiredp<='1';
        x <= cnt2;
        an <= "1011";
      when S3 =>
        wiredp<='1';
        x <= cnt3;
        an <= "0111"; 
        end case; 
      end process;

SEGMENTS: process (x) begin
    case x is
      when X"0" => seg <= "1000000";
      when X"1" => seg <= "1111001";
      when X"2" => seg <= "0100100";
      when X"3" => seg <= "0110000";
      when X"4" => seg <= "0011001";
      when X"5" => seg <= "0010010";
      when X"6" => seg <= "0000010";
      when X"7" => seg <= "1111000";
      when X"8" => seg <= "0000000";
      when X"9" => seg <= "0010000";
      when X"A" => seg <= "0001000";
      when X"B" => seg <= "0000011";
      when X"C" => seg <= "1000110";
      when X"D" => seg <= "0100001";
      when X"E" => seg <= "0000110";
      when X"F" => seg <= "0001110";
      when others => seg <= "1111111";   
    end case;
  end process;

CYCLE : process (clk) begin
    
      case (ps) is
     when S0 =>
       ns <= S1;
     
     when S1 =>
       ns <= S2;
      
     when S2 =>
       ns<= S3;
       
     when S3 =>
       ns <= S0;
       
       end case; 
     end process;
     
SYNC_PROC : process (clk)
       begin
         if rising_edge(clk) then
           if (reset = '1') then
             ps <= S0;
           else
             ps <= ns;
           end if;
         end if;
       end process; 
   
    


end Behavioral;
