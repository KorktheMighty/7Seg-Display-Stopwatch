----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2021 02:12:22 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity counter is
  generic (N: integer := 4;
          M: integer := 10);
           
   Port (          clk : in STD_LOGIC;
                   reset : in STD_LOGIC;
                   inc : out STD_LOGIC;
                   cnt : out STD_LOGIC_VECTOR (N-1 downto 0);
                   en  : in  STD_LOGIC );
end counter;

architecture Behavioral of counter is

signal cnttmp : STD_LOGIC_VECTOR(N-1 downto 0);
  signal inctmp : STD_LOGIC := '0';
  
begin
  cnt <= cnttmp;
  inc <= inctmp;
  process (clk, reset) begin
    if (reset = '1') then
      cnttmp <= CONV_STD_LOGIC_VECTOR(0,N);
      inctmp <= '0'; 
    elsif rising_edge(clk) then    
      if (cnttmp = M-1) then
        cnttmp <= CONV_STD_LOGIC_VECTOR(0,N);
       inctmp <= '1'; 
     
      
      else if en = '1' then -- if en is 0 then cnttmp wont increment hence stopping the count
        cnttmp <= cnttmp+1;
        inctmp <= '0';
        end if;
      end if;
    end if;
  end process;

-- since it counts every rising edge its going to be going to count up every 10 ns. 

end Behavioral;
