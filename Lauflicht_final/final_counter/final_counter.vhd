LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity final_counter is
	PORT (
		scaler, reset: in std_logic;
		--count :out integer range 0 to 8;
		tick : out std_logic 
		);
end entity final_counter;

architecture count of final_counter is
	
	signal tick_temp : std_logic;
	signal counter : integer range 0 to 7;
	signal state : std_logic_vector(1 downto 0);
	
begin
process(reset,scaler)
	begin
		if (reset='0') then
			counter <= 0;
		elsif(scaler'event and scaler = '1') then
			if (counter < 7) then	
				counter <= counter +1;
			else
				counter <= 0;
			end if;
		end if;
end process;

process(reset, counter)

	begin
		if (reset = '0') then
			state <= "00";
			tick_temp <= '0';
		elsif(scaler'event and scaler = '1') then
			case state is
				when "00" =>
					if (counter = 0) then
						tick_temp <= '1';
						state <= "01";
					else
						tick_temp <= '0';
						state <= "00";
					end if;
				when "01" =>
					if (counter = 5) then
						tick_temp <= '0';
						state <= "00";
					else
						tick_temp <= '1';
						state <= "01";
					end if;
				when others =>
					null;
			end case;
		end if;
	end process;
tick <= tick_temp;

--count <= counter;
end architecture count;








