LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reverse_control IS
	PORT (
		reverse_switch, reset, clk : IN STD_LOGIC;
		send_reverse : OUT STD_LOGIC --'0' go right, '1' go left
		);
END reverse_control;

ARCHITECTURE switch OF reverse_control IS
SIGNAL out_temp : STD_LOGIC;
SIGNAL state : STD_LOGIC;
BEGIN
	PROCESS (reset, clk)
	BEGIN
		IF (reset = '0') THEN
			state <= '1';  -- default to left
			out_temp <= '1';
		
		ELSIF (clk'EVENT and clk = '1') THEN
			
			CASE state IS
				WHEN '0' => --going right
					IF (reverse_switch = '0') THEN--switch is pressed
						out_temp <= '1'; --change direction to left
						state <= '1';
					ELSIF (reverse_switch = '1') THEN
						out_temp <= '0'; --keep going right
						state <= '0';
					END IF;

				WHEN '1' => -- going  left
					IF (reverse_switch = '0') THEN--switch is pressed
						out_temp <= '0';
						state <= '0';
					ELSIF (reverse_switch = '1') THEN
						out_temp <= '1'; --keep going left
						state <= '1';
					END IF;
				WHEN OTHERS =>
					NULL;
			END CASE;
		END IF;

	END PROCESS;

send_reverse <= out_temp;
END switch;