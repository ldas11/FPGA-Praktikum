library ieee;
use ieee.std_logic_1164.all;

entity scalerfilter is
	port(
	clk, reset : in std_logic;
	rythm : out std_logic
	);
end scalerfilter;

architecture speed_control of scalerfilter is

signal zustand :std_logic;
SIGNAL counter_temp : INTEGER RANGE 0 TO 1000000;
signal rythm_temp : std_logic;

BEGIN
	PROCESS(clk, reset)
	BEGIN
		IF (reset = '0') THEN 
			counter_temp <= 0; --reset the counter

		ELSIF (clk'EVENT AND clk = '1') THEN
										
					IF (counter_temp > 1000) THEN
						counter_temp <= 0;
					ELSE 
						counter_temp <= counter_temp + 1;
					END IF;
		END IF;
	END PROCESS;
	
	process(reset, clk, counter_temp)
	begin
		if (reset ='0') then
			rythm_temp <= '0';
			zustand <= '0';
		elsif (clk'event and clk ='1') then
			case zustand is
				when '0' =>
					if(counter_temp = 500) then
						rythm_temp <= '1';
						zustand <= '1';
					else	
						rythm_temp <='0';
						zustand <= '0';
					end if;
				when '1' =>
					if (counter_temp = 0) then
						rythm_temp <= '0';
						zustand <= '0';
					else
						rythm_temp <='1';
						zustand <= '1';
					end if;
			end case;
		end if;	
	end process;
rythm <= rythm_temp;
end speed_control;