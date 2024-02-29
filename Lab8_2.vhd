library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity lab8 is
  Port (
        clk, reset,st : in STD_LOGIC ;
        seg           : out STD_LOGIC_VECTOR (6 downto 0);
        an            : out STD_LOGIC_VECTOR (3 downto 0);
        dp,click, encheck    : out STD_LOGIC );     
end lab8;

architecture Behavioral of lab8 is
component clkdiv
    generic(N : integer;
            M : integer);
    port   (clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            clkout : out STD_LOGIC);
end Component ;  

component counter
    generic(N : integer;
            M : integer);
    port   (clk : in STD_LOGIC;
            reset,en : in STD_LOGIC;
            inc : out STD_LOGIC;
            cnt : out STD_LOGIC_VECTOR(N-1 downto 0));
end component; 
          
component modecontrol
    port (
          clk,reset,st : in STD_LOGIC;
          en           : out STD_LOGIC ); 
    end component;  
                 
component sevseg  
            
    port   (clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            cnt0 : in STD_LOGIC_VECTOR (3 downto 0);
            cnt1 : in STD_LOGIC_VECTOR (3 downto 0);
            cnt2 :in  STD_LOGIC_VECTOR (3 downto 0);
            cnt3 : in STD_LOGIC_VECTOR (3 downto 0);
            an : out STD_LOGIC_VECTOR (3 downto 0);
            seg : out STD_LOGIC_VECTOR (6 downto 0);
            dp  : out STD_LOGIC);
            end Component ;  
            Signal clkk, resett : STD_LOGIC ;
            Signal stwire,enwire,inc1,inc2,inc3,inc4, clk1k, clk10, clk8: STD_LOGIC;
            signal cntr1, cntr2, cntr3,cntr4: STD_LOGIC_VECTOR(3 downto 0);       
begin
    resett<=reset;
    stwire<=st;
    uut: counter generic map (4,10)
    PORT MAP(clk=>clk10, cnt=>cntr1 ,reset=>resett, inc=>inc1, en=>enwire);
    uut2: counter generic map (4,10)
    PORT MAP(clk=>inc1, cnt=>cntr2 ,reset=>resett, inc=>inc2, en=>enwire);
    uut3: counter generic map (4,10)
    PORT MAP(clk=>inc2, cnt=>cntr3 ,reset=>resett, inc=>inc3, en=>enwire);
     uut6: counter generic map (4,10)
     PORT MAP(clk=>inc3, cnt=>cntr4 ,reset=>resett, inc=>inc4, en=>enwire);
    uut4: clkdiv generic map (16,50000)
    PORT MAP(clk=>clk ,reset=>resett, clkout=>clk1k);
    uut5: clkdiv generic map (23,5000000)
    PORT MAP(clk=>clk ,reset=>resett, clkout=>clk10);
    uut7: sevseg PORT MAP(clk=>clk1k ,reset=>resett, cnt0=>cntr1, cnt1=>cntr2, cnt2=>cntr3, cnt3=>cntr4, an=>an,seg=>seg, dp=>dp); 
    uut8: modecontrol PORT MAP(clk=>clk, reset=>resett, st=>stwire, en=>enwire);   
    registerclick : process (st) begin 
    if st = '1' then click<='1';else click<='0';end if;
    if enwire = '1' then encheck<='1';else encheck<='0';end if;
    
    
    end process;

end Behavioral;
