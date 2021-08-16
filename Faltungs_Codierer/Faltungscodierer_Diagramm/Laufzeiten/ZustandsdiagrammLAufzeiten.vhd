LIBRARY ieee;
use ieee.std_logic_1164.all;

ENTITY ZustandsdiagrammLAufzeiten IS 
	PORT( d : IN STD_LOGIC; --eingegebenes bit
		  clk : IN STD_LOGIC; -- CLOCK
		  reset : IN STD_LOGIC; -- RESET
		  y0 : OUT STD_LOGIC; -- Output y0 LSB
		  y1 : OUT STD_LOGIC -- Output y0 MSB
		);
END ZustandsdiagrammLAufzeiten;

ARCHITECTURE arc OF ZustandsdiagrammLAufzeiten IS
	
	SIGNAL  ff : STD_LOGIC_VECTOR(1 downto 0); -- erstellt die FLipFlops. ff(0) ist LSB und ff(1) ist MSB eines Zustandes
	SIGNAL temp: STD_LOGIC_VECTOR(1 downto 0); -- Speichert der Wert der AusgÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¤nge fÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¼r SpÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¤ter

	BEGIN

	PROCESS(clk, reset) --Werte von CLOCK und RESET werden beachtet
		BEGIN

		IF reset = '0' THEN -- setzt eingang und FlipFlops auf Null wenn RESET Signal aktiv is
			--d <= '0';
			ff <= "00";
			temp <= "00";
		
		ELSIF(clk'EVENT AND clk = '1') THEN			-- sonst wird der Zustandsdiagramm betrachtet
			
			CASE ff IS
				WHEN "00" => 						--Zustand 00
					IF d = '0' THEN						--Eingang 0
						temp <= "00";
						--y1 <= '0';
						--y0 <= '0';						--Ausgang 00
						ff <= ff;						--neuer Zustand 00
					
					ELSIF d = '1' THEN					--Eingang 1
						temp <= "11";
						--y1 <= '1';					
						--y0 <= '1';						--Ausgang 11
						ff <= "01";						--neuer Zustand 01
					END IF;
				
				WHEN "01" =>						--Zustand 01
					IF d = '0' THEN						--Eingang 0
						temp <= "10";
						--y1 <= '1';
						--y0 <= '0';						--Ausgang 10	
						ff <= "10";						--neuer Zustand 10
					
					ELSIF d = '1' THEN					--Eingang 1
						temp <= "01";
						--y1 <= '0';
						--y0 <= '1';						--Ausgang 01	
						ff <= "11";						--neuer Zustand 11
					END IF;
				
				WHEN "11" =>						--Zustand 11
					IF d = '0' THEN						--Eingang 0
						temp <= "01";
						--y1 <= '0';
						--y0 <= '1';						--Ausgang 01	
						ff <= "10";						--neuer Zustand 10
					
					ELSIF d = '1' THEN					--Eingang 1
						temp <= "10";
						--y1 <= '1';
						--y0 <= '0';						--Ausgang 10
						ff <= ff;						--neuer Zustand 11
					END IF;

				WHEN "10" =>						--Zustand 10
					IF d = '0' THEN						--Eingang 0
						temp <= "11";
						--y1 <= '1';
						--y0 <= '1';						--Ausgang 11
						ff <= "00";						--neuer Zustand 00
					
					ELSIF d = '1' THEN					--Eingang 1
						temp <= "00";
						--y1 <= '0';						
						--y0 <= '0';						--Ausgang 00
						ff <= "01";						--neuer Zustand 01
					END IF;

				WHEN OTHERS =>						--sonst nichts machen, was niemals der Fall sein sollte
					NULL;

			END CASE;
		END IF;		
	END PROCESS;

y1 <= temp(1);
y0 <= temp(0);
		
END arc;
