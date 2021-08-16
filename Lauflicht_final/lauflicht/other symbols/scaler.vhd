library ieee;
use ieee.std_logic_1164.all;

entity scaler is
	port(
	clk, start_pause, reset, mode_switch : in std_logic;
	rythm : out std_logic
	);
end scaler;

architecture speed_control of scaler is

SIGNAL state : STD_LOGIC_VECTOR(1 downto 0);
signal zustand :std_logic;
SIGNAL counter_temp : INTEGER RANGE 0 TO 120000000;
signal rythm_temp : std_logic;

BEGIN
	PROCESS(clk, reset, start_pause, mode_switch)
	BEGIN
		IF (reset = '0') THEN 
			counter_temp <= 1; --reset the counter
			state <= "00"; --slowest mode

		ELSIF (start_pause = '0') THEN
			counter_temp <= counter_temp;
			state <= state;

		ELSIF (clk'EVENT AND clk = '1') THEN

			CASE state IS
				WHEN "00" =>
										
					IF (counter_temp > 20000000) THEN
						counter_temp <= 0;
					ELSE 
						counter_temp <= counter_temp + 1;
					END IF;

					IF (mode_switch = '0') THEN --switch is pressed
						state <= "01"; --change to next state
					ELSIF (mode_switch = '1') THEN --stay on the same state
						state <= "00";
					END IF;
				
				WHEN "01" =>
					IF (counter_temp > 80000000) THEN
						counter_temp <= 0;
					ELSE 
						counter_temp <= counter_temp + 1;
					END IF;

					IF (mode_switch = '0') THEN --next speed
						state <= "10";
					ELSIF (mode_switch = '1') THEN --same speed
						state <= "01";
					END IF;

				WHEN "10" =>
					IF (counter_temp > 120000000) THEN
						counter_temp <= 0;
					ELSE 
						counter_temp <= counter_temp + 1;
					END IF;

					IF (mode_switch = '0') THEN -- next speed
						state <= "11";
					ELSIF (mode_switch = '1') THEN -- same speed
						state <= "10";
					END IF;

				WHEN "11" =>
					IF (counter_temp > 160000000) THEN
						counter_temp <= 0;
					ELSE 
						counter_temp <= counter_temp + 1;
					END IF;

					IF (mode_switch = '0') THEN -- next speed
						state <= "00";
					ELSIF (mode_switch = '1') THEN -- same speed
						state <= "11";
					END IF;
			END CASE;
		END IF;
	END PROCESS;
	
	process(reset, clk, start_pause, counter_temp)
	begin
		if (reset ='0') then
			rythm_temp <= '0';
			zustand <= '0';
		elsif (clk'event and clk ='1') then
			case zustand is
				when '0' =>
					if(counter_temp = 0) then
						rythm_temp <= '1';
						zustand <= '1';
					else	
						rythm_temp <='0';
						zustand <= '0';
					end if;
				when '1' =>
					if (counter_temp = 10000000) then
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