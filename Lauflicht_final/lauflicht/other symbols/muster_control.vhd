library ieee;
use ieee.std_logic_1164.all;

entity muster_control is
	port(
	clk, muster_switch, reset : in std_logic;
	muster_in : in std_logic_vector(7 downto 0);
	muster_out : out std_logic_vector(7 downto 0)
	);
end muster_control;

architecture set_template of muster_control is

	signal muster_temp : std_logic_vector(7 downto 0);
	signal state : std_logic;

begin
	process(clk, reset, muster_switch, muster_in)
		begin	
			if (reset = '0') then 
				muster_temp <= "11111110";
				state <= '0';
			elsif (clk'event and clk='1') then	
				case state is
					when '0' =>
						if(muster_switch ='0')then
							muster_temp <= muster_in;
							state <= '1';
						else
							muster_temp <= "11111110";
							state <= '0';
						end if;
					when '1' =>
						if(muster_switch = '0') then
							muster_temp <= muster_in;
							state <= '1';
						else 
							muster_temp <= muster_temp;
							state <= '1';
						end if;
				end case;
			end if;
	end process;
muster_out <= muster_temp;
end set_template;