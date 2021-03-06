LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY speed_control IS
	PORT(
		clk, reset, mode_switch, start_pause : IN STD_LOGIC;
		counter : OUT INTEGER RANGE 0 to 160000001
		);
END speed_control;

ARCHITECTURE count OF speed_control IS
SIGNAL state : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL counter_temp : INTEGER RANGE 0 TO 120000000;

BEGIN
	PROCESS(clk, reset, start_pause)
	BEGIN
		IF (reset = '0') THEN 
			counter_temp <= 0; --reset the counter
			state <= "00"; --slowest mode

		ELSIF (start_pause = '1') THEN
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
counter <= counter_temp;
END count;
