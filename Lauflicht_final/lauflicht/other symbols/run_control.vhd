LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY run_control IS
	PORT(
		reset, start_switch, clk : IN STD_LOGIC;
		run_pause : OUT STD_LOGIC --'0' run, '1' pause
		);
END run_control;

ARCHITECTURE run OF run_control IS
SIGNAL state: STD_LOGIC;
SIGNAL run_pause_temp : STD_LOGIC;

BEGIN
	PROCESS(clk, reset)
	BEGIN
		IF (reset = '0') THEN
			run_pause_temp <= '0';
			state <= '1';

		ELSIF(clk'EVENT AND clk = '1') THEN
			
			CASE state IS
				WHEN '0' =>	--running
					IF (start_switch = '0') THEN -- switch is pressed
						run_pause_temp <= '0'; -- pause
						state <= '1';
					ELSIF (start_switch = '1') THEN -- switch isn't pressed
						run_pause_temp <= '1'; --keep running
						state <= '0';
					END IF;
				WHEN '1' => --paused
					IF (start_switch = '0') THEN -- switch is pressed
						run_pause_temp <= '1'; -- run
						state <= '0';
					ELSIF (start_switch = '1') THEN -- switch isn't pressed
						run_pause_temp <= '0'; --stay paused
						state <= '1';
					END IF;
				WHEN OTHERS =>
					NULL;
			END CASE;
		END IF;

	END PROCESS;

run_pause <= run_pause_temp;
END run;