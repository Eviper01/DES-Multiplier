library ieee;
use ieee.std_logic_1164.all;

entity D_flip_flop is
   port (clk,Din,rst,en : in std_logic;
            Q: out std_logic;
            Qnot : out std_logic);
 end D_flip_flop;
architecture DFF_arch of D_flip_flop is
   begin
       process (clk,en,Din,rst)
        begin
             if(en='0') then
               Q <='Z';
               Qnot <= 'Z';
             elsif(rst='1') then
               Q <='0';
               Qnot <='1';
             elsif(clk'event and clk='1') then
               Q <= Din;
               Qnot <= not Din;
             end  if;
     end process;
end DFF_arch;

library ieee;
use ieee.std_logic_1164.all;

entity MultiSim is
	port (clk,rst : in std_logic;
			Q0,Q1,Q2 : buffer std_logic
	);
end MultiSim;

architecture MultiSim_arch of MultiSim is

	component D_flip_flop is
	   port (clk,Din,rst,en : in std_logic;
            Q: out std_logic;
            Qnot : out std_logic);
	end component;

	signal D0,D1,D2, n1,n2,n3: std_logic;

	begin

	F0: D_flip_flop port map(clk, D0, rst, '1',Q0, n1);
	F1: D_flip_flop port map(clk, D1, rst, '1' ,Q1, n2);
	F2: D_flip_flop port map(clk, D2, rst, '1' ,Q2, n3);

	D0 <= ((not Q0) and (not Q2)) or ((not Q1) and Q2);
	D1 <= ((not Q0) and Q1 and (not Q2)) or ((not Q1) and Q2);
	D2 <= ((not Q0) and Q1 and Q2) or (Q0 and (not Q1));

end MultiSim_arch;
