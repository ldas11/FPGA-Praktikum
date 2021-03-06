LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY LauflichtV2 IS
	PORT (
		reset, start, reverse, muster_ubernahme: IN STD_LOGIC;
		rythm : IN INTEGER RANGE 0 TO 160000001;
		muster : IN STD_LOGIC_VECTOR(7 downto 0);
		LEDs : OUT STD_LOGIC_VECTOR(7 downto 0);
		count : OUT INTEGER RANGE 0 TO 8
	);
END LauflichtV2;

ARCHITECTURE laufen OF LauflichtV2 IS
SIGNAL LEDs_temp : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL muster_temp : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL zustand: STD_LOGIC_VECTOR(2 downto 0);
SIGNAL count_temp: INTEGER RANGE 0 TO 8;

BEGIN
	PROCESS(rythm, reset, start, reverse, muster_ubernahme, muster)
	BEGIN
		IF (reset = '0') THEN
			count_temp <= 0;
			muster_temp <= "11111110";
			zustand <= "000";

		
		ELSIF(muster_ubernahme = '0') THEN
			muster_temp <= muster;
			zustand <= "000";
		
		ELSIF (start = '1') THEN
			LEDs_temp <= LEDs_temp; 
			zustand <= zustand;
			count_temp <= count_temp;



		ELSIF (rythm = 0) THEN 

			CASE zustand IS
				WHEN "000" =>

					LEDs_temp(7) <= muster_temp(7);
					LEDs_temp(6) <= muster_temp(6);
					LEDs_temp(5) <= muster_temp(5);
					LEDs_temp(4) <= muster_temp(4);
					LEDs_temp(3) <= muster_temp(3);
					LEDs_temp(2) <= muster_temp(2);
					LEDs_temp(1) <= muster_temp(1);

					count_temp <= count_temp + 1;

					CASE reverse IS
						WHEN '0' =>
							zustand <= "111";
						WHEN '1' =>
							zustand <= "001";
					END CASE;

					
				WHEN "001" =>
					LEDs_temp(7) <= muster_temp(6);
					LEDs_temp(6) <= muster_temp(5);
					LEDs_temp(5) <= muster_temp(4);
					LEDs_temp(4) <= muster_temp(3);
					LEDs_temp(3) <= muster_temp(2);
					LEDs_temp(2) <= muster_temp(1);
					LEDs_temp(1) <= muster_temp(0);
					LEDs_temp(0) <= muster_temp(7);

					count_temp <= count_temp + 1;

					CASE reverse IS
						WHEN '0' =>
							zustand <= "000";
						WHEN '1' =>
							zustand <= "010";
					END CASE;

				WHEN "010" =>
					LEDs_temp(7) <= muster_temp(5);
					LEDs_temp(6) <= muster_temp(4);
					LEDs_temp(5) <= muster_temp(3);
					LEDs_temp(4) <= muster_temp(2);
					LEDs_temp(3) <= muster_temp(1);
					LEDs_temp(2) <= muster_temp(0);
					LEDs_temp(1) <= muster_temp(7);
					LEDs_temp(0) <= muster_temp(6);

					count_temp <= count_temp + 1;

					CASE reverse IS
						WHEN '0' =>
							zustand <= "001"; --previous
						WHEN '1' =>
							zustand <= "011"; --next
					END CASE;

				WHEN "011" =>
					LEDs_temp(7) <= muster_temp(4);
					LEDs_temp(6) <= muster_temp(3);
					LEDs_temp(5) <= muster_temp(2);
					LEDs_temp(4) <= muster_temp(1);
					LEDs_temp(3) <= muster_temp(0);
					LEDs_temp(2) <= muster_temp(7);
					LEDs_temp(1) <= muster_temp(6);
					LEDs_temp(0) <= muster_temp(5);

					count_temp <= count_temp + 1;

					CASE reverse IS
						WHEN '0' =>
							zustand <= "010";
						WHEN '1' =>
							zustand <= "100";
					END CASE;

				WHEN "100" =>
					LEDs_temp(7) <= muster_temp(3);
					LEDs_temp(6) <= muster_temp(2);
					LEDs_temp(5) <= muster_temp(1);
					LEDs_temp(4) <= muster_temp(0);
					LEDs_temp(3) <= muster_temp(7);
					LEDs_temp(2) <= muster_temp(6);
					LEDs_temp(1) <= muster_temp(5);
					LEDs_temp(0) <= muster_temp(4);

					count_temp <= count_temp + 1;

					CASE reverse IS
						WHEN '0' =>
							zustand <= "011";
						WHEN '1' =>
							zustand <= "101";
					END CASE;

				WHEN "101" =>
					LEDs_temp(7) <= muster_temp(2);
					LEDs_temp(6) <= muster_temp(1);
					LEDs_temp(5) <= muster_temp(0);
					LEDs_temp(4) <= muster_temp(7);
					LEDs_temp(3) <= muster_temp(6);
					LEDs_temp(2) <= muster_temp(5);
					LEDs_temp(1) <= muster_temp(4);
					LEDs_temp(0) <= muster_temp(3);

					count_temp <= count_temp + 1;

					CASE reverse IS
						WHEN '0' =>
							zustand <= "100";
						WHEN '1' =>
							zustand <= "110";
					END CASE;

				WHEN "110" =>
					LEDs_temp(7) <= muster_temp(1);
					LEDs_temp(6) <= muster_temp(0);
					LEDs_temp(5) <= muster_temp(7);
					LEDs_temp(4) <= muster_temp(6);
					LEDs_temp(3) <= muster_temp(5);
					LEDs_temp(2) <= muster_temp(4);
					LEDs_temp(1) <= muster_temp(3);
					LEDs_temp(0) <= muster_temp(2);

					count_temp <= count_temp + 1;

					CASE reverse IS
						WHEN '0' =>
							zustand <= "101";
						WHEN '1' =>
							zustand <= "111";
					END CASE;

				WHEN "111" =>
					LEDs_temp(7) <= muster_temp(0);
					LEDs_temp(6) <= muster_temp(7);
					LEDs_temp(5) <= muster_temp(6);
					LEDs_temp(4) <= muster_temp(5);
					LEDs_temp(3) <= muster_temp(4);
					LEDs_temp(2) <= muster_temp(3);
					LEDs_temp(1) <= muster_temp(2);
					LEDs_temp(0) <= muster_temp(1);

					count_temp <= count_temp + 1;

					CASE reverse IS --cambiar por ifs y poner el else
						WHEN '0' =>
							zustand <= "110";
						WHEN '1' =>
							zustand <= "000";
					END CASE;

				WHEN OTHERS =>
					NULL;
					
			END CASE;
		END IF;
		
		IF (count_temp > 8) THEN
			count_temp <= 0;
		END IF;
	END PROCESS;

LEDs <= LEDs_temp;
count <= count_temp;
END laufen;

