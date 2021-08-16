LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY seven_segment_decoder IS
	PORT(
		reset : IN STD_LOGIC;
		count_8 : IN INTEGER RANGE 0 TO 8;
		u32, u33 : OUT STD_LOGIC_VECTOR(7 downto 0)
		);
END seven_segment_decoder;

ARCHITECTURE segment_control OF seven_segment_decoder IS


SIGNAL u32_temp : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL u33_temp : STD_LOGIC_VECTOR(7 downto 0);




BEGIN
	PROCESS(count_8,reset)
	VARIABLE internal_counter : INTEGER RANGE 0 TO 99;
	VARIABLE tens : INTEGER RANGE 0 TO 9 := 0;
	VARIABLE ones : INTEGER RANGE 0 TO 9 := 0;
	BEGIN
		IF (reset = '0') THEN
			internal_counter := 0;
		ELSIF(count_8 = 0) THEN 
			internal_counter := internal_counter + 1;
		ELSIF(internal_counter > 99) THEN
			internal_counter := 0;
		END IF;

		tens := (internal_counter / 10);
		ones := (internal_counter mod 10);
		
		CASE tens IS
			WHEN 0 => 
				u32_temp <= "00000011";
			WHEN 1 =>
				u32_temp <= "10011111";
			WHEN 2 =>
				u32_temp <= "00100101";
			WHEN 3 =>
				u32_temp <= "00001101";
			WHEN 4 =>
				u32_temp <= "10011101";
			WHEN 5 =>
				u32_temp <= "01001001";
			WHEN 6 =>
				u32_temp <= "01000001";
			WHEN 7 =>
				u32_temp <= "00011111";
			WHEN 8 =>
				u32_temp <= "00000001";
			WHEN 9 =>
				u32_temp <= "00011001";
			WHEN OTHERS =>
				NULL;
	   END CASE;
	
		CASE ones IS
			WHEN 0 => 
				u33_temp <= "00000011";
			WHEN 1 =>
				u33_temp <= "10011111";
			WHEN 2 =>
				u33_temp <= "00100101";
			WHEN 3 =>
				u33_temp <= "00001101";
			WHEN 4 =>
				u33_temp <= "10011101";
			WHEN 5 =>
				u33_temp <= "01001001";
			WHEN 6 =>
				u33_temp <= "01000001";
			WHEN 7 =>
				u33_temp <= "00011111";
			WHEN 8 =>
				u33_temp <= "00000001";
			WHEN 9 =>
				u33_temp <= "00011001";
			WHEN OTHERS =>
				NULL;
		END CASE;
	END PROCESS;
u32 <= u32_temp;
u33 <= u33_temp;

END segment_control;