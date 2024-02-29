----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2021 02:12:22 PM
-- Design Name: 
-- Module Name: clkdiv - Behavioral
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
entity clkdiv is
  generic (N: integer := 17;
           M: integer := 100000);
  Port ( clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         clkout : out STD_LOGIC);
end clkdiv;

architecture Behavioral of clkdiv is
  signal cnt : STD_LOGIC_VECTOR(N-1 downto 0);
  signal clktmp : STD_LOGIC := '0';
begin
  clkout <= clktmp;
  process (clk) begin
    if rising_edge(clk) then
    
      if (reset = '1') then
        cnt <= CONV_STD_LOGIC_VECTOR(0,N);
        clktmp <= '0';
      elsif (cnt = M-1) then
        cnt <= CONV_STD_LOGIC_VECTOR(0,N);
        clktmp <= not clktmp;
      else
        cnt <= cnt+1;
      end if;
    end if;
  end process;


end Behavioral;
